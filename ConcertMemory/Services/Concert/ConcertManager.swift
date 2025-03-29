//
//  ConcertManager.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//
import SwiftUI

protocol ConcertService: Sendable {
    func createConcert(concert: ConcertModel, image: UIImage) async throws
}

struct MockConcertService: ConcertService {
    func createConcert(concert: ConcertModel, image: UIImage) async throws {
        
    }
}

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseConcertService: ConcertService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("concerts")
    }
    
    func createConcert(concert: ConcertModel, image: UIImage) async throws {
        // Upload the image
        let path = "concertImages/\(concert.id)"
        let url = try await FirebaseImageUploadService().uploadImage(image: image, path: path)
        
        // Update concert header image url
        var concert = concert
        concert.updateConcertHeaderImageUrl(imageUrl: url.absoluteString)
        
        // Upload the concert
        try collection.document(concert.id).setData(from: concert, merge: true)
    }
}

@MainActor
@Observable
class ConcertManager {
    private let service: ConcertService
    
    init(service: ConcertService) {
        self.service = service
    }
    
    func createConcert(concert: ConcertModel, image: UIImage) async throws {
        try await service.createConcert(concert: concert, image: image)
        
    }
    
}
