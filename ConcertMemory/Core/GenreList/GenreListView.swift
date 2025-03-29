//
//  GenreListView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//

import SwiftUI

struct GenreListView: View {
    
    @Binding var path: [NavigationPathOption]
    var genre: ConcertGenre = .blues
    var imageName: String = Constants.randomImage
    
    @State private var concerts: [ConcertModel] = ConcertModel.mocks
    
    var body: some View {
        List {
            GenreCellView(title: genre.rawValue.capitalized, imageName: imageName, font: .largeTitle, cornerRadius: 0)
                .removeListRowFormatting()
            
            ForEach(concerts) { concert in
                CustomListCellView(imageName: concert.concertHeaderImageUrl, title: concert.artist, subtitle: concert.venue)
                    .anyButton {
                        onConcertPressed(concert: concert)
                    }
            }
            .removeListRowFormatting()
        }
        .ignoresSafeArea()
        .listStyle(PlainListStyle())
    }
    
    private func onConcertPressed(concert: ConcertModel) {
        path.append(.concert(concert: concert, concertId: concert.id))
    }
}

#Preview {
    GenreListView(path: .constant([]))
}
