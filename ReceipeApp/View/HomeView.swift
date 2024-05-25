//
//  ContentView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import SwiftUI

struct HomeView: View {
    @State private var dessertList: [Dessert] = [Dessert]()
    @State private var searchText = ""
    @State private var isOnboardingComplete = false
    @State private var isLoading = false
    @State private var hasFetchedData = false
    @ObservedObject private var viewModel: DessertViewModel = DessertViewModel()
    
    var body: some View {
        
        /// onboarding view appears only for cold start sessions
        if !isOnboardingComplete {
            onboading
        } else {
            homePage
            .onAppear {
                if !hasFetchedData {
                    isLoading = true
                    viewModel.fetchDesserts()
                    hasFetchedData = true
                }
            }
            .onReceive(viewModel.$desserts) { value in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isLoading = false
                    self.dessertList = value
                }
            }
            .navigationViewStyle(.stack) /// Avoids list view being attached to leading edge in iPad views
            .listStyle(.plain) /// Avoid additional background color around list view
        }
    }
    
    private var onboading: some View {
        OnboardingView()
            .onAppear {
               // Use a Timer to change the view to home after 5 seconds
               DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                   isOnboardingComplete = true
               }
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
                .onAppear {
                    if !hasFetchedData {
                        isLoading = true
                        viewModel.fetchDesserts()
                        hasFetchedData = true
                    }
                }
                .onReceive(viewModel.$desserts) { value in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        isLoading = false
                        self.dessertList = value
                    }
                }
            }
            .navigationViewStyle(.stack)
            .listStyle(.plain)
            
            if isLoading {
                LoadingView()
                    .ignoresSafeArea(.all)
            }
        }
    }
    
    private var desserts: some View {
        ScrollViewReader { proxy in
            HStack {
                List(dessertList.filter {
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
                ScrollIndexView(dessertList: dessertList , proxy: proxy)
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
