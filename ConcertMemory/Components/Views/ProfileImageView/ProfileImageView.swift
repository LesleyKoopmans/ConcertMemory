//
//  ProfileImageView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//

import SwiftUI

struct ProfileImageView: View {
    
    var imageName: String = Constants.randomImage
    
    var body: some View {
        ImageLoaderView(urlString: imageName)
    }
}

#Preview {
    ProfileImageView()
        .clipShape(Circle())
        .frame(width: 140)
}
