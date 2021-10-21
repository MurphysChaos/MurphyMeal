//
//  QueryHandler.swift
//  Murphy Meal
//
//  Created by Joel Murphy on 10/10/21.
//

import UIKit

enum QueryHandlerError: Error {
    case dataTaskError
    case httpError
    case noDataAvailable
    case failedToProcessData
    case payloadNotAnImage
}

class QueryHandler {

    // MARK:- URL factory methods

    static func urlForCategoryList() -> URL? {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")
    }

    static func urlForRecipeList(_ category: Category) -> URL? {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category.strCategory)")
    }

    static func urlForRecipeDetails(_ recipe: Recipe) -> URL? {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipe.idMeal)")
    }

    // MARK:- REST query handlers

    static func fetchCategoryList(completionHandler: @escaping(Result<Categories, QueryHandlerError>) -> Void) {

        if let url = urlForCategoryList() {
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { (data, response, error) in

                if let _ = error {
                    completionHandler(.failure(.dataTaskError))
                }

                // Require a successful HTTP response
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(.failure(.httpError))
                    return
                }

                // Handle the returned data --
                if let data = data {

                    let decoder = JSONDecoder()

                    do {
                        let feed = try decoder.decode(Categories.self, from: data)
                        completionHandler(.success(feed))

                    } catch {
                        completionHandler(.failure(.failedToProcessData))
                    }

                } else {
                    completionHandler(.failure(.noDataAvailable))
                }
            }.resume()
        }
    }

    static func fetchRecipeList(category: Category, completionHandler: @escaping(Result<FilterResult, QueryHandlerError>) -> Void) {

        if let url = urlForRecipeList(category) {
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { (data, response, error) in

                if let _ = error {
                    completionHandler(.failure(.dataTaskError))
                }

                // Require a successful HTTP response
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(.failure(.httpError))
                    return
                }

                // Handle the returned data
                if let data = data {

                    let decoder = JSONDecoder()

                    do {
                        let feed = try decoder.decode(FilterResult.self, from: data)
                        completionHandler(.success(feed))

                    } catch {
                        completionHandler(.failure(.failedToProcessData))
                    }

                } else {
                    completionHandler(.failure(.noDataAvailable))
                }
            }.resume()
        }
    }

    static func fetchRecipeDetails(recipe: Recipe, completionHandler: @escaping(Result<LookupResult, QueryHandlerError>) -> Void) {

        if let url = urlForRecipeDetails(recipe) {
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { (data, response, error) in

                if let _ = error {
                    completionHandler(.failure(.dataTaskError))
                }

                // Require a successful HTTP response
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(.failure(.httpError))
                    return
                }

                // Handle the returned data
                if let data = data {

                    let decoder = JSONDecoder()

                    do {
                        let feed = try decoder.decode(LookupResult.self, from: data)
                        completionHandler(.success(feed))

                    } catch {
                        completionHandler(.failure(.failedToProcessData))
                    }

                } else {
                    completionHandler(.failure(.noDataAvailable))
                }
            }.resume()
        }
    }

    // MARK:- Downloaders

    static func fetchImage(urlString: String, completionHandler: @escaping(Result<UIImage, QueryHandlerError>) -> Void) {

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { (data, response, error) in

                if let _ = error {
                    completionHandler(.failure(.dataTaskError))
                }

                // Require a successful HTTP response
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(.failure(.httpError))
                    return
                }

                // Handle the returned image
                if let data = data {
                    if let image = UIImage(data: data) {
                        completionHandler(.success(image))
                    } else {
                        completionHandler(.failure(.payloadNotAnImage))
                    }
                } else {
                    completionHandler(.failure(.noDataAvailable))
                }
            }.resume()
        }
    }
}
