//
//  ContentView.swift
//  Sajeon
//
//  Created by Xianmo on 13/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            Tab("Search", systemImage: "magnifyingglass", value: 0) {
                SearchView()
            }

            Tab("Favourites", systemImage: "star.fill", value: 1) {
                FavouritesView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
