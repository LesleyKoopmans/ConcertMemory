//  OnboardingCompletedView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct OnboardingCompletedView: View {
    
    @State private var isCompletingProfileSetup: Bool = false
    @Environment(AppState.self) private var root
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        VStack {
            introSection
            
            buttonSection
            
        }
        .padding(16)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var introSection: some View {
        VStack(spacing: 12) {
            Group {
                Text("Welcome to Concert Memory")
                    .font(.largeTitle)
                    .foregroundStyle(.accent)
                    .padding(.bottom, 12)
                
                Text("With this app can keep a diary off all the concerts you went through. Keep memories about all the beatiful nights you had and remember the fun times!")
                
                Text("Please click Finish to get started with app. Upload your first memories and sign up to our service so you can share memories!")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var buttonSection: some View {
        AsyncCallToActionButton(
            isLoading: isCompletingProfileSetup,
            title: "Finish",
            action: {
                onFinishButtonPressed()
            }
        )
        .callToActionButton()
    }
    
    func onFinishButtonPressed() {
        isCompletingProfileSetup = true
        
        Task {
            try await userManager.markOnboardingCompleteForCurrentUser()
            // dismiss screen
            isCompletingProfileSetup = false
            root.updateViewState(showTabBarView: true)
            
        }
    }
    
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
        .environment(UserManager(services: MockUserServices()))
}
