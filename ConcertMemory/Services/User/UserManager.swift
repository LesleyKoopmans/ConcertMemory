//
//  UserManager.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 28/03/2025.
//
import SwiftUI

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String) async throws
}

struct MockUserService: UserService {
    
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func saveUser(user: UserModel) async throws {
        
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {
        
    }
    
    func markOnboardingCompleted(userId: String) async throws {
        
    }
    
    
}

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseUserService: UserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) async throws {
        try collection.document(user.id).setData(from: user, merge: true)
    }
    
    func markOnboardingCompleted(userId: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true
        ])
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
    
}

@MainActor
@Observable
class UserManager {
    
    private let service: UserService
    private(set) var currentUser: UserModel?
    
    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        
        try await service.saveUser(user: user)
        
        addCurrentUserListener(userId: auth.uid)
    }
    
    private func addCurrentUserListener(userId: String) {
        Task {
            do {
                for try await value in service.streamUser(userId: userId) {
                    self.currentUser = value
                    print("Successfully listened to user: \(value.id)")
                }
            } catch {
                print("Error attaching userlistener: \(error)")
            }
        }
    }
    
    func markOnboardingCompleteForCurrentUser() async throws {
        let uid = try currentUserId()
        try await service.markOnboardingCompleted(userId: uid)
    }
    
    func signOut() {
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await service.deleteUser(userId: uid)
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
