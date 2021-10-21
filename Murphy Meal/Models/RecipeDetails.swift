//
//  RecipeDetails.swift
//  Murphy Meal
//
//  Created by Joel Murphy on 10/11/21.
//

import Foundation

// API method "lookup" top-level object
struct LookupResult: Decodable {
    var meals: [RecipeDetails]
}

struct RecipeDetails: Decodable {

    // Values provided by category filter API
    var idMeal: String
    var strMeal: String
    var strDrinkAlternate: String?
    var strCategory: String?
    var strInstructions: String?
    var strMealThumb: String
    var strTags: String?
    var strYoutube: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    var strSource: String?
    var strImageSource: String?
    var strCreativeCommonsConfirmed: String?
    var dateModified: String?

    var ingredients: [String] = [String]()
    var measurements: [String] = [String]()

    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strInstructions, strMealThumb, strTags, strYoutube, strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20, strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20, strSource, strImageSource, strCreativeCommonsConfirmed, dateModified
    }

    mutating public func buildIngredientArrays() {

        ingredients.removeAll()
        measurements.removeAll()

        // For each row, make sure that both parts have a value -- this is potentially problematic as I'm not sure if the API has any ingedients with a blank measurement but I'm trying to keep things simple.

        if !(strIngredient1?.isEmpty ?? true) && !(strMeasure1?.isEmpty ?? true) {
            ingredients.append(strIngredient1!)
            measurements.append(strMeasure1!)
        }

        if !(strIngredient2?.isEmpty ?? true) && !(strMeasure2?.isEmpty ?? true) {
            ingredients.append(strIngredient2!)
            measurements.append(strMeasure2!)
        }

        if !(strIngredient3?.isEmpty ?? true) && !(strMeasure3?.isEmpty ?? true) {
            ingredients.append(strIngredient3!)
            measurements.append(strMeasure3!)
        }

        if !(strIngredient4?.isEmpty ?? true) && !(strMeasure4?.isEmpty ?? true) {
            ingredients.append(strIngredient4!)
            measurements.append(strMeasure4!)
        }

        if !(strIngredient5?.isEmpty ?? true) && !(strMeasure5?.isEmpty ?? true) {
            ingredients.append(strIngredient5!)
            measurements.append(strMeasure5!)
        }

        if !(strIngredient6?.isEmpty ?? true) && !(strMeasure6?.isEmpty ?? true) {
            ingredients.append(strIngredient6!)
            measurements.append(strMeasure6!)
        }

        if !(strIngredient7?.isEmpty ?? true) && !(strMeasure7?.isEmpty ?? true) {
            ingredients.append(strIngredient7!)
            measurements.append(strMeasure7!)
        }

        if !(strIngredient8?.isEmpty ?? true) && !(strMeasure8?.isEmpty ?? true) {
            ingredients.append(strIngredient8!)
            measurements.append(strMeasure8!)
        }

        if !(strIngredient9?.isEmpty ?? true) && !(strMeasure9?.isEmpty ?? true) {
            ingredients.append(strIngredient9!)
            measurements.append(strMeasure9!)
        }

        if !(strIngredient10?.isEmpty ?? true) && !(strMeasure10?.isEmpty ?? true) {
            ingredients.append(strIngredient10!)
            measurements.append(strMeasure10!)
        }

        if !(strIngredient11?.isEmpty ?? true) && !(strMeasure11?.isEmpty ?? true) {
            ingredients.append(strIngredient11!)
            measurements.append(strMeasure11!)
        }

        if !(strIngredient12?.isEmpty ?? true) && !(strMeasure12?.isEmpty ?? true) {
            ingredients.append(strIngredient12!)
            measurements.append(strMeasure12!)
        }

        if !(strIngredient13?.isEmpty ?? true) && !(strMeasure13?.isEmpty ?? true) {
            ingredients.append(strIngredient13!)
            measurements.append(strMeasure13!)
        }

        if !(strIngredient14?.isEmpty ?? true) && !(strMeasure14?.isEmpty ?? true) {
            ingredients.append(strIngredient14!)
            measurements.append(strMeasure14!)
        }

        if !(strIngredient15?.isEmpty ?? true) && !(strMeasure15?.isEmpty ?? true) {
            ingredients.append(strIngredient15!)
            measurements.append(strMeasure15!)
        }

        if !(strIngredient16?.isEmpty ?? true) && !(strMeasure16?.isEmpty ?? true) {
            ingredients.append(strIngredient16!)
            measurements.append(strMeasure16!)
        }

        if !(strIngredient17?.isEmpty ?? true) && !(strMeasure17?.isEmpty ?? true) {
            ingredients.append(strIngredient17!)
            measurements.append(strMeasure17!)
        }

        if !(strIngredient18?.isEmpty ?? true) && !(strMeasure18?.isEmpty ?? true) {
            ingredients.append(strIngredient18!)
            measurements.append(strMeasure18!)
        }

        if !(strIngredient19?.isEmpty ?? true) && !(strMeasure19?.isEmpty ?? true) {
            ingredients.append(strIngredient19!)
            measurements.append(strMeasure19!)
        }

        if !(strIngredient20?.isEmpty ?? true) && !(strMeasure20?.isEmpty ?? true) {
            ingredients.append(strIngredient20!)
            measurements.append(strMeasure20!)
        }
    }
}
