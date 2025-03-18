//
//  CustomListCellView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 18/03/2025.
//

import SwiftUI

struct CustomListCellView: View {
    
    var imageName: String? = Constants.randomImage
    var title: String? = "Atmosphere"
    var subtitle: String? = "Underground Hiphop in de Melkweg."
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.5))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 16))
                
            VStack(alignment: .leading, spacing: 4) {
                if let title = title {
                    Text(title)
                        .font(.headline)
                }
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .padding(.vertical, 4)
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        VStack {
            CustomListCellView()
            CustomListCellView(imageName: nil)
            CustomListCellView(title: nil)
            CustomListCellView(subtitle: nil)
        }
        
    }
}
