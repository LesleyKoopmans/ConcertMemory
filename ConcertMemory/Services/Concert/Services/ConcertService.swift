//
//  ConcertService.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 29/03/2025.
//
import SwiftUI

protocol ConcertService: Sendable {
    func createConcert(concert: ConcertModel, image: UIImage) async throws
    func getRecentConcerts() async throws -> [ConcertModel]
    func getPopularConcerts() async throws -> [ConcertModel]
    func getConcertsForGenre(genre: ConcertGenre) async throws -> [ConcertModel]
    func getConcertsForAuthor(userId: String) async throws -> [ConcertModel]
}
