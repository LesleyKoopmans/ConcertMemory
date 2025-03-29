//
//  UserModel.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 25/03/2025.
//

import Foundation

struct UserModel: Codable, Identifiable, Hashable {
    
    let id: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    private(set) var profileImageUrl: String?
    
    init(
        id: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileImageUrl: String? = nil
    ) {
        self.id = id
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileImageUrl = profileImageUrl
    }
    
    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(
            id: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationDate: auth.creationDate,
            creationVersion: creationVersion,
            lastSignInDate: auth.lastSignInDate
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileImageUrl = "profile_image_url"
    }
    
    mutating func updateProfileImageUrl(imageUrl: String) {
        profileImageUrl = imageUrl
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        return [
            UserModel(id: "mock_user_1", creationDate: .now, didCompleteOnboarding: true, profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/concertmemory-f3e4b.firebasestorage.app/o/concertImages%2FA40E24BC-7D4E-40D4-B315-6EB660F272DB.jpg?alt=media&token=64ae3ee5-ea6c-4aba-a781-8c8e648b933e"),
            UserModel(id: UUID().uuidString, creationDate: .now, didCompleteOnboarding: false, profileImageUrl: "https://picsum.photos/600/500"),
            UserModel(id: UUID().uuidString, creationDate: .now, didCompleteOnboarding: true, profileImageUrl: nil),
            UserModel(id: UUID().uuidString, creationDate: .now, didCompleteOnboarding: true, profileImageUrl: "https://picsum.photos/500/500")
        ]
    }
}
