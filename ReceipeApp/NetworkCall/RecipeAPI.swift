//
//  ReceipeAPI.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
let desserrtsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
let receipeURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="

class RecipeAPI {
    
    // fetch list of meals
    func fetchDessertList() async throws -> [Dessert] {
        let url = URL(string: desserrtsURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let receipe = try JSONDecoder().decode(Recipe.self, from: data)
        return receipe.meals
    }
    
    // fetch meal receipe
    func fetchReceipe(mealID: String) async throws -> Meal? {
        let url = URL(string: receipeURL + mealID)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealArray = try JSONDecoder().decode(MealsResponse.self, from: data)
        return mealArray.meals[0]
    }
}
