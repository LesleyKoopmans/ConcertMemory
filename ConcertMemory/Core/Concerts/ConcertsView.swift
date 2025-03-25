//
//  ConcertsView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 25/03/2025.
//

import SwiftUI

struct ConcertsView: View {
    
    @State private var concerts: [ConcertModel] = ConcertModel.mocks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(concerts) { concert in
                    ConcertRowCellView(imageName: concert.profileImageName, title: concert.artist, subtitle: concert.subtitle)
                        .anyButton {
                            
                        }
                        .removeListRowFormatting()
                }
            }
                .navigationTitle("Concerts")
        }
    }
}

#Preview {
    ConcertsView()
}
