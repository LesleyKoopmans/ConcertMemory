//
//  RemoteUserService.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//
import SwiftUI

protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String) async throws
    func updateProfileImageUrl(user: UserModel, image: UIImage) async throws
}
