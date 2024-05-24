//
//  DessertListView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
import SwiftUI

// Reusable view that is used in two differnt places as rows
struct DessertListView: View {
    let name: String
    let url: String?
    let qty: String?
    var body: some View {
        HStack{
            Spacer()
            if let url = url {
                ImageView(imageURL: url)
            }
            Spacer()
            Text(name)
                .frame(maxWidth: .infinity,alignment: .center)
            Spacer()
            if let qty = qty {
                Text(qty)
            }
        }
        .padding(.all)
    }
}
