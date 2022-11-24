//
//  SajeonApp.swift
//  Sajeon
//
//  Created by シェイミ on 24/11/2022.
//

import SwiftUI

@main
struct Handict3App: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
