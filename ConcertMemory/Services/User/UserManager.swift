//
//  UserManager.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 28/03/2025.
//
import SwiftUI

@MainActor
@Observable
class UserManager {
    
    private let remote: RemoteUserService
    private let local: LocalUserPersistence
    private(set) var currentUser: UserModel?
    
    init(services: UserServices) {
        self.remote = services.remote
        self.local = services.local
        self.currentUser = local.getCurrentUser()
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        
        try await remote.saveUser(user: user)
        
        addCurrentUserListener(userId: auth.uid)
    }
    
    private func addCurrentUserListener(userId: String) {
        Task {
            do {
                for try await value in remote.streamUser(userId: userId) {
                    self.currentUser = value
                    self.saveCurrentUserLocally()
                    print("Successfully listened to user: \(value.id)")
                }
            } catch {
                print("Error attaching userlistener: \(error)")
            }
        }
    }
    
    private func saveCurrentUserLocally() {
        Task {
            do {
                try local.saveCurrentUser(user: currentUser)
                print("Success saved current user locally")
            } catch {
                print("Error saving current user locally: \(error)")
            }
        }
    }
    
    func markOnboardingCompleteForCurrentUser() async throws {
        let uid = try currentUserId()
        try await remote.markOnboardingCompleted(userId: uid)
    }
    
    func signOut() {
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await remote.deleteUser(userId: uid)
        signOut()
    }
    
    private func currentUserId() throws -> String {
        guard let uid = currentUser?.id else {
            throw UserManagerError.noUserId
        }
        
        return uid
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
