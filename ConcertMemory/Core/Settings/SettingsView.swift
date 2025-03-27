//
//  SettingsView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.authService) private var authService
    @Environment(AppState.self) private var appState
    
    @State private var isPremium: Bool = false
    @State private var isAnonymousUser: Bool = true
    @State private var showCreateAccountView: Bool = false
    @State private var showAlert: AnyAppAlert?
    
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
            .onAppear {
                setAnonymousAccountStatus()
            }
            .showCustomAlert(alert: $showAlert)
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
                    onDeleteAccountPressed()
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
    
    func onDeleteAccountPressed() {
        showAlert = AnyAppAlert(
            title: "Delete Account",
            subtitle: "Are you sure you want to delete your account?",
            buttons: {
                AnyView(
                    Button("Delete", role: .destructive) {
                        
                    }
                )
            }
        )
    }
    
    func setAnonymousAccountStatus() {
        isAnonymousUser = authService.getAuthenticatedUser()?.isAnonymous == true
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
