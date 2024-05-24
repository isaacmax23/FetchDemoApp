//
//  ContentViewModel.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation

class HomeViewModel {
    
    func loadDessertsList() async  -> [Dessert]? {
        var dessertList: [Dessert]?
        do {
            dessertList = try await RecipeAPI().fetchDessertList()
            dessertList = dessertList?.filter {!$0.strMeal.isEmpty || !$0.idMeal.isEmpty} // filter out empty strings
            dessertList?.sort { $0.strMeal < $1.strMeal }
        } catch {
            dessertList = nil
        }
        return dessertList
    }
    
}
