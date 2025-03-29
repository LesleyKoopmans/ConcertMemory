//
//  FirebaseUserService.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//


import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseUserService: RemoteUserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) async throws {
        try collection.document(user.id).setData(from: user, merge: true)
    }
    
    func markOnboardingCompleted(userId: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true
        ])
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
    
    func updateProfileImageUrl(user: UserModel, image: UIImage) async throws {
        // Upload the image
        let path = "userImages/\(user.id)"
        let url = try await FirebaseImageUploadService().uploadImage(image: image, path: path)
        
        // Update profile image url
        var user = user
        user.updateProfileImageUrl(imageUrl: url.absoluteString)
        
        // Update the user in Firebase
        try collection.document(user.id).setData(from: user, merge: true)
        
        // TO DO: Delete previous image from Firebase
    }
    
}
