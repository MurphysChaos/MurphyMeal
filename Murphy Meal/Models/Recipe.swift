//
//  Recipe.swift
//  Murphy Meal
//
//  Created by Joel Murphy on 10/10/21.
//

import Foundation

// API method "filter" top-level object
struct FilterResult: Decodable {
    var meals: [Recipe]
}

struct Recipe: Decodable {

    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}
