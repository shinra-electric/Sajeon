//
//  SajeonApp.swift
//  Sajeon
//
//  Created by Xianmo on 13/02/2024.
//

import SwiftUI

@main
struct Handict3App: App {
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        
        LaunchScreen(config: .init(scaling: 12)) {
            Image(.launchScreenLogo)
        } rootContent: {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
