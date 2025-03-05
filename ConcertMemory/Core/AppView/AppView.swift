//
//  AppView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct AppView: View {
    
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
    }
}

#Preview("Appview - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("Appview - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
