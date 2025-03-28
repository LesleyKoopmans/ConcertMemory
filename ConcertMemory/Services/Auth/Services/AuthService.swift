//
//  AuthService.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 28/03/2025.
//
import SwiftUI

protocol AuthService: Sendable {
    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?>
    func getAuthenticatedUser() -> UserAuthInfo?
    func signInAnomymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() throws
    func deleteAccount() async throws
}
