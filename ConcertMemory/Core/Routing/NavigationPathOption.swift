//
//  NavigationPathOption.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//
import SwiftUI
import Foundation

enum NavigationPathOption: Hashable {
    case concert(concert: ConcertModel, concertId: String)
    case genre(genre: ConcertGenre, imageName: String)
}

extension View {
    func navigationDestinationForCoreModule(path: Binding<[NavigationPathOption]>) -> some View {
        self
            .navigationDestination(for: NavigationPathOption.self) { newValue in
                switch newValue {
                case .concert(concert: let concert, concertId: let concertId):
                    ConcertDetailView(concert: concert, concertId: concertId)
                case .genre(genre: let genre, imageName: let imageName):
                    GenreListView(path: path, genre: genre, imageName: imageName)
                }
            }
    }
}
