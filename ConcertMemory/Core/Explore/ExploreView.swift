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
    
    var body: some View {
        NavigationStack {
            List {
                recentSection
                
                genreSection
                
                popularSection
            }
            .navigationTitle("Explore")

        }
    }
    
    private var recentSection: some View {
        Section {
            ZStack {
                CarouselView(items: recentConcerts) { concert in
                    HeroCellView(
                        title: concert.artist,
                        subtitle: concert.subtitle,
                        imageName: concert.profileImageName
                    )
                    .anyButton(.plain) {
                        
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
                            GenreCellView(
                                title: genre.rawValue.capitalized,
                                imageName: Constants.randomImage
                            )
                            .anyButton(.plain) {
                                
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
                    imageName: concert.profileImageName,
                    title: concert.artist,
                    subtitle: concert.subtitle
                )
                .anyButton(.highlight) {
                    
                }
                .removeListRowFormatting()
            }
        } header: {
            Text("Popular")
        }
    }
}

#Preview {
    ExploreView()
}
