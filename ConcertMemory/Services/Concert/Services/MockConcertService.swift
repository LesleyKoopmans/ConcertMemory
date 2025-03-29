//
//  MockConcertService.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//
import SwiftUI

struct MockConcertService: ConcertService {
    func createConcert(concert: ConcertModel, image: UIImage) async throws {
        
    }
    
    func getRecentConcerts() async throws -> [ConcertModel] {
        try await Task.sleep(for: .seconds(1))
        return ConcertModel.mocks.shuffled()
    }
    
    func getPopularConcerts() async throws -> [ConcertModel] {
        try await Task.sleep(for: .seconds(2))
        return ConcertModel.mocks.shuffled()
    }
    
    func getConcertsForGenre(genre: ConcertGenre) async throws -> [ConcertModel] {
        try await Task.sleep(for: .seconds(2))
        return ConcertModel.mocks.shuffled()
    }
    
    func getConcertsForAuthor(userId: String) async throws -> [ConcertModel] {
        try await Task.sleep(for: .seconds(2))
        return ConcertModel.mocks.shuffled()
    }
    
}
