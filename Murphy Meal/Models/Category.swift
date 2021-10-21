//
//  Category.swift
//  Murphy Meal
//
//  Created by Joel Murphy on 10/7/21.
//

import Foundation

// The top-level element is a JSON object with a key of "categories", containing an array of Category objects.
struct Categories: Decodable {
    var categories: [Category]
}

// Represents an individual Category object
struct Category: Decodable {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}
