//
//  ExploreView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct ExploreView: View {
    
    let concert = ConcertModel.mock
    @State private var recentConcerts: [ConcertModel] = ConcertModel.mocks
    @State private var genres: [ConcertGenre] = ConcertGenre.allCases
    @State private var popularConcerts: [ConcertModel] = ConcertModel.mocks
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                recentSection
                
                genreSection
                
                popularSection
            }
            .navigationTitle("Explore")
            .navigationDestinationForCoreModule(path: $path)
        }
    }
    
    private var recentSection: some View {
        Section {
            ZStack {
                CarouselView(items: recentConcerts) { concert in
                    HeroCellView(
                        title: concert.artist,
                        imageUrl: concert.concertHeaderImageUrl
                    )
                    .anyButton(.plain) {
                        onConcertPressed(concert: concert)
                    }
                }
            }
            .removeListRowFormatting()
        } header: {
            Text("Recent Concerts")
        }
    }
    
    private var genreSection: some View {
        Section {
            ZStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(genres, id: \.self) { genre in
                            if let imageName = popularConcerts.first(where: { $0.concertGenre == genre })?.concertHeaderImageUrl {
                                GenreCellView(
                                    title: genre.rawValue.capitalized,
                                    imageName: genre.headerImage
                                )
                                .anyButton(.plain) {
                                    onGenrePressed(genre: genre, imageName: genre.headerImage)
                                }
                            }
                        }
                    }
                }
                .frame(height: 140)
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
            }
            .removeListRowFormatting()
        } header: {
            Text("Genres")
        }
    }
    
    private var popularSection: some View {
        Section {
            ForEach(popularConcerts, id: \.self) { concert in
                CustomListCellView(
                    imageName: concert.concertHeaderImageUrl,
                    title: concert.artist
                )
                .anyButton(.highlight) {
                    onConcertPressed(concert: concert)
                }
                .removeListRowFormatting()
            }
        } header: {
            Text("Popular")
        }
    }
    
    private func onConcertPressed(concert: ConcertModel) {
        path.append(.concert(concert: concert, concertId: concert.id))
    }
    
    private func onGenrePressed(genre: ConcertGenre, imageName: String) {
        path.append(.genre(genre: genre, imageName: imageName))
    }
}

#Preview {
    ExploreView()
}
