//
//  AppView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct AppView: View {

    @AppStorage("showTabbarView") var showTabBar: Bool = false

    var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
    }
}

#Preview("Appview - Tabbar") {
    AppView(showTabBar: true)
}

#Preview("Appview - Onboarding") {
    AppView(showTabBar: false)
}
