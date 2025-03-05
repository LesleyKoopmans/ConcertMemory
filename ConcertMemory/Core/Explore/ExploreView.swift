//
//  ExploreView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct ExploreView: View {
    
    let concert = ConcertModel.mock
    
    var body: some View {
        NavigationStack {
            HeroCellView(
                title: concert.artist,
                subtitle: concert.subtitle,
                imageName: concert.profileImageName
            )
            .frame(height: 200)
                .navigationTitle("Explore")

        }
    }
}

#Preview {
    ExploreView()
}
