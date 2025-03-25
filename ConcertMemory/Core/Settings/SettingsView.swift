//
//  SettingsView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    
    @State private var isPremium: Bool = false
    @State private var isAnonymousUser: Bool = true
    @State private var showCreateAccountView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchaseSection
                applicationSection
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showCreateAccountView) {
                CreateAccountView()
                    .presentationDetents([.medium])
            }
        }
    }
    
    private var accountSection: some View {
        Section {
            if isAnonymousUser {
                Text("Save & back-up account")
                    .rowFormatting()
                    .anyButton {
                        onCreateAccountPressed()
                    }
                    .removeListRowFormatting()
            } else {
                Text("Sign out")
                    .rowFormatting()
                    .anyButton {
                        onSignOutPressed()
                    }
                    .removeListRowFormatting()
            }
                        
            Text("Delete account")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton {
                    
                }
                .removeListRowFormatting()
        } header: {
            Text("Account")
        }
    }
    
    private var purchaseSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Account status: \(isPremium ? "PREMIUM" : "FREE")")
                Spacer(minLength: 0)
                Text(isPremium ? "MANAGE" : "UPGRADE")
                    .badgeButton()
            }
            .rowFormatting()
            .anyButton {
                
            }
            .removeListRowFormatting()
        } header: {
            Text("Purchases")
        }

    }
    
    private var applicationSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Version")
                Spacer(minLength: 0)
                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
            }
            HStack(spacing: 8) {
                Text("Build number")
                Spacer(minLength: 0)
                Text(Utilities.buildNumber ?? "")
                    .foregroundStyle(.secondary)
            }
            
            Text("Contact us")
                .foregroundStyle(.accentColorLightGreen)
                .anyButton {
                    
                }
            
        } header: {
            Text("Application")
        } footer: {
            Text("Created by Lesley Koopmans")
        }

    }
    
    func onSignOutPressed() {
        dismiss()
        Task {
            try? await Task.sleep(for: .seconds(1))
            appState.updateViewState(showTabBarView: false)
        }
    }
    
    func onCreateAccountPressed() {
        showCreateAccountView = true
    }
}

fileprivate extension View {
    func rowFormatting() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
