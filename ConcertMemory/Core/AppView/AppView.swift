//
//  AppView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct AppView: View {
    
    @Environment(AuthManager.self) private var authManager
    @State var appState = AppState()
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, newValue in
            if !newValue {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }
    
    private func checkUserStatus() async {
        if let user = authManager.auth {
            print("User already authenticated: \(user.uid)")
        } else {
            do {
                let result = try await authManager.signInAnomymously()
                
                print("Sign in anonymous succes: \(result.user.uid)")
            } catch {
                print(error)
            }
        }
    }
}

#Preview("Appview - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("Appview - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
