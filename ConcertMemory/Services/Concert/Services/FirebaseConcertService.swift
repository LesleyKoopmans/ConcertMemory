//
//  FirebaseConcertService.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//
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
    
    func getRecentConcerts() async throws -> [ConcertModel] {
        try await collection
            .order(by: ConcertModel.CodingKeys.concertDate.rawValue, descending: true)
            .limit(to: 6)
            .getAllDocuments()
    }
    
    func getPopularConcerts() async throws -> [ConcertModel] {
        try await collection
            .order(by: ConcertModel.CodingKeys.rating.rawValue, descending: true)
            .limit(to: 10)
            .getAllDocuments()
    }
    
    func getConcertsForGenre(genre: ConcertGenre) async throws -> [ConcertModel] {
        try await collection
            .whereField(ConcertModel.CodingKeys.concertGenre.rawValue, isEqualTo: genre.rawValue)
            .getAllDocuments()
    }
    
    func getConcertsForAuthor(userId: String) async throws -> [ConcertModel] {
        try await collection
            .whereField(ConcertModel.CodingKeys.authorId.rawValue, isEqualTo: userId)
            .getAllDocuments()
    }
}
