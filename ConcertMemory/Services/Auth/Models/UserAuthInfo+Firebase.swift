//
//  UserAuthInfo+Firebase.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//
import FirebaseAuth

extension UserAuthInfo {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
