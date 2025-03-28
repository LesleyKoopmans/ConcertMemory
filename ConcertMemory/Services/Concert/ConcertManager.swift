//
//  ConcertManager.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//
import SwiftUI

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
    
    func getRecentConcerts() async throws -> [ConcertModel] {
        try await service.getRecentConcerts()
    }
    
    func getPopularConcerts() async throws -> [ConcertModel] {
        try await service.getPopularConcerts()
    }
    
    func getConcertsForGenre(genre: ConcertGenre) async throws -> [ConcertModel] {
        try await service.getConcertsForGenre(genre: genre)
    }
    
    func getConcertsForAuthor(userId: String) async throws -> [ConcertModel] {
        try await service.getConcertsForAuthor(userId: userId)
    }
    
}
