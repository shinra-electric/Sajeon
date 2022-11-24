//
//  ContentView.swift
//  Sajeon
//
//  Created by シェイミ on 24/11/2022.
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
