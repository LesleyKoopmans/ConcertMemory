//
//  ExploreView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct ExploreView: View {
    
    @Environment(ConcertManager.self) private var concertManager
    @State private var recentConcerts: [ConcertModel] = []
    @State private var genres: [ConcertGenre] = ConcertGenre.allCases
    @State private var popularConcerts: [ConcertModel] = []
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                if recentConcerts.isEmpty && popularConcerts.isEmpty {
                    ProgressView()
                        .padding(40)
                        .frame(maxWidth: .infinity)
                        .removeListRowFormatting()
                }
                
                if !recentConcerts.isEmpty {
                    recentSection
                }
                
                if !popularConcerts.isEmpty {
                    genreSection
                    popularSection
                }
                
            }
            .navigationTitle("Explore")
            .navigationDestinationForCoreModule(path: $path)
            .task {
                await loadRecentConcerts()
            }
            .task {
                await loadPopularConcerts()
            }
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
    
    private func loadRecentConcerts() async {
        guard recentConcerts.isEmpty else { return }
        
        do {
            recentConcerts = try await concertManager.getRecentConcerts()
        } catch {
            print("Error loading recent concerts: \(error)")
        }
    }
    
    private func loadPopularConcerts() async {
        guard popularConcerts.isEmpty else { return }
        do {
            popularConcerts = try await concertManager.getPopularConcerts()
        } catch {
            print("Error loading popular concerts: \(error)")
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
        .environment(ConcertManager(service: MockConcertService()))
}
