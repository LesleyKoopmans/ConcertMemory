//
//  UserModel.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 25/03/2025.
//

import Foundation

struct UserModel {
    
    let userId: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileImageUrl: String?
    
    init(
        userId: String,
        dateCreated: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileImageUrl: String? = nil
    ) {
        self.userId = userId
        self.dateCreated = dateCreated
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileImageUrl = profileImageUrl
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        return [
            UserModel(userId: UUID().uuidString, dateCreated: .now, didCompleteOnboarding: true, profileImageUrl: Constants.randomImage),
            UserModel(userId: UUID().uuidString, dateCreated: .now, didCompleteOnboarding: false, profileImageUrl: Constants.randomImage),
            UserModel(userId: UUID().uuidString, dateCreated: .now, didCompleteOnboarding: true, profileImageUrl: Constants.randomImage),
            UserModel(userId: UUID().uuidString, dateCreated: .now, didCompleteOnboarding: true, profileImageUrl: Constants.randomImage)
        ]
    }
}
