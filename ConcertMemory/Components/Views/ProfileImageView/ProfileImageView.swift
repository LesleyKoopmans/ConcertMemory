//
//  ProfileImageView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//

import SwiftUI

struct ProfileImageView: View {
    
    var imageName: String?
    var onProfileImagePressed: (() -> Void)?
    
    var body: some View {
        if let imageName = imageName {
            ImageLoaderView(urlString: imageName)
        } else {
            ZStack {
                Circle()
                    .fill(.accent.opacity(0.8))
                Image(systemName: "person.fill")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    ProfileImageView()
        .clipShape(Circle())
        .frame(width: 140)
}
