//
//  FileManagerUserPersistent.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//
import SwiftUI

struct FileManagerUserPersistent: LocalUserPersistence {
    private let userDocumentKey = "current_user"
    
    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
