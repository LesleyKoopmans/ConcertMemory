//
//  GenreListView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//

import SwiftUI

struct GenreListView: View {
    
    @Environment(ConcertManager.self) private var concertManager
    
    @Binding var path: [NavigationPathOption]
    var genre: ConcertGenre = .blues
    var imageName: String = Constants.randomImage
    
    @State private var concerts: [ConcertModel] = []
    @State private var showAlert: AnyAppAlert?
    @State private var isLoading: Bool = true
    
    var body: some View {
        List {
            GenreCellView(title: genre.rawValue.capitalized, imageName: imageName, font: .largeTitle, cornerRadius: 0)
                .removeListRowFormatting()
            
            if concerts.isEmpty && isLoading {
                ProgressView()
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
                    .removeListRowFormatting()
            } else {
                ForEach(concerts) { concert in
                    CustomListCellView(imageName: concert.concertHeaderImageUrl, title: concert.artist)
                        .anyButton {
                            onConcertPressed(concert: concert)
                        }
                }
                .removeListRowFormatting()
            }
            
        }
        .showCustomAlert(alert: $showAlert)
        .ignoresSafeArea()
        .listStyle(PlainListStyle())
        .task {
            await loadConcerts()
        }
    }
    
    private func loadConcerts() async {
        do {
            concerts = try await concertManager.getConcertsForGenre(genre: genre)
        } catch {
            showAlert = AnyAppAlert(title: error.localizedDescription)
        }
        isLoading = false
    }
    
    private func onConcertPressed(concert: ConcertModel) {
        path.append(.concert(concert: concert, concertId: concert.id))
    }
}

#Preview {
    GenreListView(path: .constant([]))
        .environment(ConcertManager(service: MockConcertService()))
}
