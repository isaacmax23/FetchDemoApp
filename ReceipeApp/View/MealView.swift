//
//  DessertMainView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
import SwiftUI

/// Detailed view of dessert receipe with instructions & ingredients
struct MealView: View {
    let mealId: String
    @ObservedObject private var viewModel: MealViewModel = MealViewModel()
    @State private var meal: Meal?
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HeadingView(text: meal?.strMeal ?? "Sorry, Image not available")
                ImageView(imageURL: meal?.strMealThumb)
                Text(meal?.strInstructions ?? "")
                    .padding(.bottom)
                if let ingredients = meal?.ingredients, let qty = meal?.paddedMeasures {
                    MealDetailView(ingredients: ingredients, paddedMeasures: qty)
                }
            }
        }
        .padding(.all)
        .onAppear {
            viewModel.fetchMeal(withId: mealId)
        }
        .onReceive(viewModel.$meal) { meal in
            self.meal = meal
        }
    }
}

private struct MealDetailView: View {
    let ingredients: [String]
    let paddedMeasures: [String]
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            Text("Ingredients")
                .bold()
                .font(.title2)
            Text("Quantity")
                .bold()
                .font(.title2)
            Divider()
            Divider()
            ForEach(Array(0..<ingredients.count), id: \.self) { i in
                Text(ingredients[i])
                Text(paddedMeasures[i])
                Divider()
                Divider()
            }
        }
        .padding(.all)
    }
}

