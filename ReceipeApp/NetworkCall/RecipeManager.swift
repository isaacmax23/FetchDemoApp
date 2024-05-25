//
//  ReceipeAPI.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
protocol ReceipeService {
    func fetchDessertList() async throws -> [Dessert]
    func fetchRecipe(mealID: String) async throws -> Meal?
}

enum RecipeError: Error {
    case invalidURL
    case invalidJsonFormat(Error)
}

class ReceipeManager: ReceipeService {
    
    private enum API: String {
        case desserts = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        case receipe = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    }
    
    /// *fetch list of meals*
    /// Fetch desert List
    ///  - Returns:  [Dessert]
    ///  - Throws: RecipeError
    func fetchDessertList() async throws -> [Dessert] {
        guard let url = URL(string: API.desserts.rawValue) else {
            throw RecipeError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipe = try JSONDecoder().decode(Recipe.self, from: data)
            return recipe.meals
        } catch let decodingError as DecodingError {
            throw RecipeError.invalidJsonFormat(decodingError)
        } catch {
            throw error
        }
    }
    
    /// *fetch meal receipe*
    /// Fetch meal recipe based on IDs
    ///  - Parameters:
    ///    - mealId: String
    ///  - Returns: Meal?
    ///  - Throws: RecipeError
    func fetchRecipe(mealID: String) async throws -> Meal? {
        guard let url = URL(string: API.receipe.rawValue + mealID) else {
            throw RecipeError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealArray = try JSONDecoder().decode(MealsResponse.self, from: data)
            return mealArray.meals.first
        } catch let decodingError as DecodingError {
            throw RecipeError.invalidJsonFormat(decodingError)
        } catch {
            throw error
        }
    }
}
