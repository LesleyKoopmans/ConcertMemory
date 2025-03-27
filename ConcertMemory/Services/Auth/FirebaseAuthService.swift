//
//  FirebaseAuthService.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//
import FirebaseAuth
import SwiftUI
import SignInAppleAsync

extension EnvironmentValues {
    @Entry var authService: FirebaseAuthService = FirebaseAuthService()
}

struct FirebaseAuthService {
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        if let user = Auth.auth().currentUser {
            return UserAuthInfo(user: user)
        }
        return nil
    }
    
    func signInAnomymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        return result.asAuthInfo
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = await SignInWithAppleHelper()
        let response = try await helper.signIn()
        
        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: response.token,
            rawNonce: response.nonce
        )
        
        let result = try await Auth.auth().signIn(with: credential)
        
        return result.asAuthInfo
    }
}

extension AuthDataResult {
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)

    }
}
