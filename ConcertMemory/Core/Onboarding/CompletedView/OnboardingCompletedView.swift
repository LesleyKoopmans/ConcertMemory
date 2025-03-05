//  OnboardingCompletedView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct OnboardingCompletedView: View {
    
    @Environment(AppState.self) private var root
    
    var body: some View {
        VStack {
            Text("Onboarding Completed!")
                .frame(maxHeight: .infinity)
            
            Button {
                onFinishButtonPressed()
            } label: {
                Text("Finish")
                    .callToActionButton()
            }
        }
        .padding(16)
    }
    
    func onFinishButtonPressed() {
        root.updateViewState(showTabBarView: true)
    }
    
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
