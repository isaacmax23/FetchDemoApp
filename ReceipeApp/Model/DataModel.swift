//
//  DataModel.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation

struct Receipe: Codable {
    let meals: [Dessert]
}

struct MealArray: Codable {
    let meal: [Meal]
}

struct Dessert: Codable, Identifiable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    var id: String {
        return idMeal
    }
}


struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    var ingredients: [String] {
        return [
            strIngredient1,
            strIngredient2,
            strIngredient3,
            strIngredient4,
            strIngredient5,
            strIngredient6,
            strIngredient7,
            strIngredient8,
            strIngredient9,
            strIngredient10,
            strIngredient11,
            strIngredient12,
            strIngredient13,
            strIngredient14,
            strIngredient15,
            strIngredient16,
            strIngredient17,
            strIngredient18,
            strIngredient19,
            strIngredient20
        ].compactMap { $0 }.filter { !$0.isEmpty }
    }
    
    var measures: [String] {
           return [
               strMeasure1,
               strMeasure2,
               strMeasure3,
               strMeasure4,
               strMeasure5,
               strMeasure6,
               strMeasure7,
               strMeasure8,
               strMeasure9,
               strMeasure10,
               strMeasure11,
               strMeasure12,
               strMeasure13,
               strMeasure14,
               strMeasure15,
               strMeasure16,
               strMeasure17,
               strMeasure18,
               strMeasure19,
               strMeasure20
           ].compactMap { $0 }.filter { !$0.isEmpty }
       }
    
    var paddedMeasures: [String] {
        var paddedMeasures = measures
           
           // Pad the measures array with empty strings if it's shorter than ingredients
           while paddedMeasures.count < ingredients.count {
               paddedMeasures.append("")
           }
        
        while paddedMeasures.count > ingredients.count {
            paddedMeasures.removeLast()
        }
        
        return paddedMeasures
    }
    
//    var safeDict: [String: String] {
//        var dict = [String: String]()
//           for (ingredient, measure) in zip(ingredients, measures) {
//               dict[ingredient] = measure
//           }
//           return dict
//    }
    
//    var safeDict: [(ingredient: String, measure1: String)] {
//        var tuple = [(ingredient: String, measure1: String)]()
//        var paddedMeasures = measures
//           
//           // Pad the measures array with empty strings if it's shorter than ingredients
//           while paddedMeasures.count < ingredients.count {
//               paddedMeasures.append("")
//           }
//
//           return Array(zip(ingredients, paddedMeasures))
//    }
}

struct MealsResponse: Codable {
    let meals: [Meal]
}