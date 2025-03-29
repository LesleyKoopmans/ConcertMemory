//
//  LocalUserPersistence.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//


protocol LocalUserPersistence {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}