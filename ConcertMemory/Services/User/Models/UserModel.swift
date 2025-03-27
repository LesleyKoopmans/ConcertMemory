//
//  UserModel.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 25/03/2025.
//

import Foundation

struct UserModel: Identifiable, Hashable {
    
    let id: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileImageUrl: String?
    
    init(
        id: String,
        dateCreated: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileImageUrl: String? = nil
    ) {
        self.id = id
        self.dateCreated = dateCreated
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileImageUrl = profileImageUrl
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        return [
            UserModel(id: "mock_user_1", dateCreated: .now, didCompleteOnboarding: true, profileImageUrl: Constants.randomImage),
            UserModel(id: UUID().uuidString, dateCreated: .now, didCompleteOnboarding: false, profileImageUrl: "https://picsum.photos/600/500"),
            UserModel(id: UUID().uuidString, dateCreated: .now, didCompleteOnboarding: true, profileImageUrl: nil),
            UserModel(id: UUID().uuidString, dateCreated: .now, didCompleteOnboarding: true, profileImageUrl: "https://picsum.photos/500/500")
        ]
    }
}
