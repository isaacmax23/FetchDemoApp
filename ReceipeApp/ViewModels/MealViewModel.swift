//
//  MealViewModel.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/25/24.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
    @Published var meal: Meal?
    private var receipeManager: ReceipeService
    
    init(receipeManager: ReceipeService = ReceipeManager()) {
        self.receipeManager = receipeManager
    }
    
    func fetchMeal(withId id: String) {
        Task(priority: .background) {
            do {
                let meal = try await self.receipeManager.fetchRecipe(mealID: id)
                DispatchQueue.main.async {
                    self.meal = meal
                }
            } catch RecipeError.invalidURL {
                /// Handle invalid URL error
                print("Invalid URL")
            } catch RecipeError.invalidJsonFormat(let decodingError) {
                /// Handle JSON decoding error
                print("JSON Decoding Error: \(decodingError)")
            } catch {
                /// Handle other errors
                print("Unexpected Error: \(error)")
            }
        }
    }
}
