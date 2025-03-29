//
//  SettingsView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
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
            .sheet(isPresented: $showCreateAccountView, onDismiss: {
                setAnonymousAccountStatus()
            }, content: {
                CreateAccountView()
                    .presentationDetents([.medium])
            })
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
        Task {
            do {
                try authManager.signOut()
                try userManager.signOut()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(title: error.localizedDescription)
            }
            
        }
    }
    
    func onCreateAccountPressed() {
        showCreateAccountView = true
    }
    
    func onDeleteAccountPressed() {
        showAlert = AnyAppAlert(
            title: "Delete Account?",
            subtitle: "Are you sure you want to delete your account?",
            buttons: {
                AnyView(
                    Button("Delete", role: .destructive) {
                        onDeleteAccountConfirmed()
                    }
                )
            }
        )
    }
    
    private func onDeleteAccountConfirmed() {
        Task {
            do {
                try await authManager.deleteAccount()
                try await userManager.deleteCurrentUser()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(title: error.localizedDescription)
            }
        }
    }
    
    func setAnonymousAccountStatus() {
        isAnonymousUser = authManager.auth?.isAnonymous == true
    }
    
    private func dismissScreen() async {
        dismiss()
        try? await Task.sleep(for: .seconds(1))
        appState.updateViewState(showTabBarView: false)
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

#Preview("No Auth") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: nil)))
        .environment(UserManager(services: MockUserServices(user: nil)))
        .environment(AppState())
}

#Preview("Anonymous") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: UserAuthInfo.mock(isAnonymous: true))))
        .environment(UserManager(services: MockUserServices(user: .mock)))
        .environment(AppState())
}

#Preview("Not Anonymous") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: UserAuthInfo.mock(isAnonymous: false))))
        .environment(UserManager(services: MockUserServices(user: .mock)))
        .environment(AppState())
}
