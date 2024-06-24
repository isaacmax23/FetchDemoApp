//
//  ContentView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import SwiftUI
struct HomeView: View {
    @State private var searchText = ""
    @State private var isOnboardingComplete = false
    @State private var isLoading = false
    @ObservedObject private var viewModel: DessertViewModel = DessertViewModel()
    
    var body: some View {
        
        /// onboarding view appears only for cold start sessions
        if !isOnboardingComplete {
            onboading
        } else {
            homePage
            .navigationViewStyle(.stack) /// Avoids list view being attached to leading edge in iPad views
            .listStyle(.plain) /// Avoid additional background color around list view
        }
    }
    
    private var onboading: some View {
        OnboardingView()
            .task {
                try? await Task.sleep(nanoseconds: 1 * 1_000_000_000) // 3 seconds delay
                isOnboardingComplete = true
            }
    }
    
    private var homePage: some View {
        ZStack {
            NavigationView {
                VStack {
                    HeadingView(text: "Recipes")
                    ClippedTextField(text: $searchText)
                        .padding([.leading,.trailing])
                        .frame(alignment: .top)
                    desserts
                }
                .task {
                    if !viewModel.hasFetchedData {
                        isLoading = true
                        viewModel.fetchDesserts()
                        viewModel.hasFetchedData = true
                    }
                }
                .onReceive(viewModel.$desserts) { value in

                    if !value.isEmpty {
                        isLoading = false
                    }
                }
              
            }

            if isLoading {
                LoadingView()
                    .ignoresSafeArea(.all)
            }
        }
    }
    
    private var desserts: some View {
        ScrollViewReader { proxy in
            HStack {
                List(viewModel.desserts.filter {
                    self.searchText.isEmpty ||
                    $0.strMeal.localizedCaseInsensitiveContains(searchText)
                }) { dessert in
                    NavigationLink {
                        MealView(mealId: dessert.idMeal)
                    } label: {
                        /// Reusable List Row
                        DessertListView(name: dessert.strMeal, url: dessert.strMealThumb, qty: nil)
                    }
                }
                Spacer()
                ScrollIndexView(dessertList: viewModel.desserts , proxy: proxy)
            }
        }
        .padding()
    }

}


#Preview {
    HomeView()
}
