//
//  LaunchScreen.swift
//  SplashScreen
//
//  Created by Séamus on 2025/11/16.
//

import SwiftUI

struct LaunchScreen<RootView: View, Logo: View>: Scene {
    var config: LaunchScreenConfig = .init()
    @ViewBuilder var logo: () -> Logo
    @ViewBuilder var rootContent: RootView
    var body: some Scene {
        WindowGroup {
            rootContent
                .modifier(LaunchScreenModifier(config: config, logo: logo))
        }
    }
}

fileprivate struct LaunchScreenModifier<Logo: View>: ViewModifier {
    var config: LaunchScreenConfig
    @ViewBuilder var logo: Logo
    @Environment(\.scenePhase) private var scenePhase
    @State private var splashWindow: UIWindow?
    func body(content: Content) -> some View {
        content
            /// Add overlay window so the splash screen is placed on top of the entire app
            .onAppear {
                let scenes = UIApplication.shared.connectedScenes
                
                for scene in scenes {
                    guard let windowScene = scene as? UIWindowScene,
                            checkStates(windowScene.activationState),
                            /// Check whether the window scene already has a splash screen
                            !windowScene.windows.contains(where: { $0.tag == 100 })
                    else {
                        print("This scene already has a splash window")
                        continue
                    }
                    
                    let window = UIWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    let rootViewController = UIHostingController(rootView: LaunchScreenView(config: config) {
                        logo
                    } isCompleted: {
                        window.isHidden = true
                        window.isUserInteractionEnabled = false
                    })
                    window.tag = 100
                    rootViewController.view.backgroundColor = .clear
                    window.rootViewController = rootViewController
//                    window.tag = 1009
//                    window.makeKeyAndVisible()
                    self.splashWindow = window
                    print("Splash window added")
                }
            }
    }
    
    private func checkStates(_ state: UIWindowScene.ActivationState) -> Bool {
        switch scenePhase {
        case .background:
            return state == .background
        case .inactive:
            return state == .foregroundInactive
        case .active:
            return state == .foregroundActive
        default: return state.hashValue == scenePhase.hashValue
        }
    }
}

/// Launch Screen Config for more customisation
struct LaunchScreenConfig {
    var initialDelay: Double = 0.35
    var backgroundColor: Color = .sajeonBlue
    var logoBackgroundColor: Color = .white
    var scaling: CGFloat = 4
    var forceHideLogo: Bool = false
    // Some customisation
    var animation: Animation = .smooth(duration: 1, extraBounce: 0)
}

fileprivate struct LaunchScreenView<Logo: View>: View {
    var config: LaunchScreenConfig
    @ViewBuilder var logo: Logo
    var isCompleted: () -> ()
    /// View Properties
    @State private var scaleDown: Bool = false
    @State private var scaleUp: Bool = false
    var body: some View {
        Rectangle()
            .fill(config.backgroundColor)
            // Reverse logo masking
            .mask {
                GeometryReader {
                    let size = $0.size.applying(.init(scaleX: config.scaling, y: config.scaling))
                    
                    Rectangle()
                        .overlay {
                            logo
                                .blur(radius: config.forceHideLogo ? 0 : (scaleUp ? 15 : 0))
                                .blendMode(.destinationOut)
                                .animation(.smooth(duration: 0.3, extraBounce: 0)) { content in
                                    content
                                        .scaleEffect(scaleDown ? 0.8 : 1)
                                }
                                .visualEffect { [scaleUp] content, proxy in
                                    let scaleX: CGFloat = size.width / proxy.size.width
                                    let scaleY: CGFloat = size.height / proxy.size.height
                                    let maxScale = Swift.max(scaleX, scaleY)
                                    
                                    return content
                                        .scaleEffect(scaleUp ? maxScale : 1)
                                }
                        }
                }
            }
            .opacity(config.forceHideLogo ? 1 : (scaleUp ? 0 : 1))
            .background {
                Rectangle()
                    .fill(config.logoBackgroundColor)
                // Hide background gradually as logo is scaling up
                    .opacity(scaleUp ? 0: 1)
            }
            .ignoresSafeArea()
            .task {
                guard !scaleDown else { return }
                try? await Task.sleep(for: .seconds(config.initialDelay))
                scaleDown = true
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation(config.animation, completionCriteria: .logicallyComplete) {
                    scaleUp = true
                } completion: {
                    isCompleted()
                }
            }
    }
}
