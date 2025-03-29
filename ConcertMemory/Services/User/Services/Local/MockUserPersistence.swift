//
//  MockUserPersistence.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//


struct MockUserPersistence: LocalUserPersistence {
    
    let currentUser: UserModel?
    
    init(user: UserModel?) {
        self.currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        
    }
}