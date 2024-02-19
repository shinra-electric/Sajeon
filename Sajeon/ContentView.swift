//
//  ContentView.swift
//  Sajeon
//
//  Created by Xianmo on 13/02/2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FavouritesView()
                .tabItem {
                    Label("Favourites", systemImage: "star.fill")
                }
        }
        .backgroundStyle(.ultraThinMaterial)
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
