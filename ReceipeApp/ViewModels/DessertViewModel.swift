//
//  ContentViewModel.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
import Combine

class DessertViewModel: ObservableObject {
    @Published var desserts: [Dessert] = []
    private var receipeManager: ReceipeService
    
    init(receipeManager: ReceipeService = ReceipeManager()) {
        self.receipeManager = receipeManager
    }
    
    func fetchDesserts() {
        Task(priority: .background) {
            do {
                let dessertList = try await self.receipeManager.fetchDessertList()
                let filteredAndSortedDesserts = dessertList
                    .filter { !$0.strMeal.isEmpty && !$0.idMeal.isEmpty } // filter out empty strings
                    .sorted { $0.strMeal < $1.strMeal } // sort desserts
                DispatchQueue.main.async {
                    self.desserts = filteredAndSortedDesserts
                }
            } catch RecipeError.invalidURL {
                // Handle invalid URL error
                print("Invalid URL")
            } catch RecipeError.invalidJsonFormat(let decodingError) {
                // Handle JSON decoding error
                print("JSON Decoding Error: \(decodingError)")
            } catch {
                // Handle other errors
                print("Unexpected Error: \(error)")
            }
        }
    }
}

