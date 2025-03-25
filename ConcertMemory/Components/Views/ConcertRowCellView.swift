//
//  ConcertRowCellView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 25/03/2025.
//

import SwiftUI

struct ConcertRowCellView: View {
    
    var imageName: String? = Constants.randomImage
    var title: String? = "Atmosphere"
    var subtitle: String? = "Underground Hiphop in de Melkweg"
    
    var body: some View {
        HStack {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.5))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color(uiColor: UIColor.systemBackground))
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        List {
            ConcertRowCellView()
                .removeListRowFormatting()
            ConcertRowCellView(title: nil)
                .removeListRowFormatting()
            ConcertRowCellView(imageName: nil)
                .removeListRowFormatting()
            ConcertRowCellView(subtitle: nil)
                .removeListRowFormatting()
        }
    }
}
