//
//  MockUserService.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//
import SwiftUI

struct MockUserService: RemoteUserService {
    
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
    
    func updateProfileImageUrl(user: UserModel, image: UIImage) async throws {
        
    }
    
}
