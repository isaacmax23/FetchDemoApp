//
//  ReusableViews.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/25/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(width: 50, height: 50)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .overlay(
                    Image(systemName: "circle.dotted")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.black)
                        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                        .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false), value: isAnimating)
                )
                .padding()
        }
        .onAppear {
            self.isAnimating = true
        }
    }
}

struct HeadingView: View {
     var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding()
    }
}

/// TextField can be reused
struct ClippedTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Enter text", text: $text)
            .padding(5)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}

/// scroll index can be reused
struct ScrollIndexView: View {
    var dessertList: [Dessert]
    var proxy: ScrollViewProxy
    @State private var selectedLetter: String? = nil
    
    private var alphabet: [String] {
        return Array(Set(dessertList.compactMap { $0.strMeal.prefix(1).uppercased() })).sorted()
    }
    
    /// Index letter and first meal that matches it
    private  var alphabetMealDict: [String: String] {
        var map = [String: String]()
        for dessert in dessertList {
           let letter = String(dessert.strMeal.prefix(1)).uppercased()
           if map[letter] == nil {
               map[letter] = dessert.idMeal
           }
        }
        return map
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(alphabet, id: \.self) { letter in
                        Text(letter)
                            .font(.headline)
                            .padding(.vertical, 4)
                            .foregroundColor(selectedLetter == letter ? .blue : .primary)
                            .onTapGesture {
                                selectedLetter = letter
                                let dessertId = alphabetMealDict[letter]
                                if let id = dessertId {
                                    withAnimation {
                                        proxy.scrollTo(id, anchor: .top)
                                    }
                                }
                            }
                }
            }
            .frame(width: 30,alignment: .trailing)
        }
    }
}


struct ImageView: View {
    let imageURL: String?
    
    var body: some View {
        
        if let imageURL = imageURL, let url = URL(string: imageURL) {
               AsyncImage(url: url) { phase in
                   switch phase {
                   case .empty:
                       ProgressView("Loading...")
                   case .success(let image):
                       image
                           .resizable()
                           .scaledToFit()
                           .frame(width: 100, height: 100)
                           .clipShape(.circle)
                   case .failure:
                       Text("Sorry, no image found")
                   @unknown default:
                       Text("Sorry, no image found")
                   }
               }
           }
       
    }
}
