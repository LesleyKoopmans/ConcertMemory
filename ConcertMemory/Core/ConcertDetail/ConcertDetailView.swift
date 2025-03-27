//
//  ConcertDetailView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 26/03/2025.
//

import SwiftUI

struct ConcertDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var concert: ConcertModel = ConcertModel.mock
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                imageSection
                infoSection
                
                descriptionSection
                
                mediaSection
                
                additionalSection
            }
            
            headerSection
        }
        .ignoresSafeArea()
    }
    
    private var headerSection: some View {
        ZStack {
            Image(systemName: "xmark")
                .foregroundStyle(.white)
                .font(.title3)
                .padding(10)
                .background(.accent)
                .clipShape(Circle())
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .anyButton {
                    dismiss()
                }
        }
        .frame(height: 150)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var imageSection: some View {
        ZStack {
            if let imageUrl = concert.profileImageName {
                ImageLoaderView(urlString: imageUrl)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .overlay(alignment: .bottomLeading) {
            HStack {
                if let artist = concert.artist {
                    Text(artist)
                        .font(.title)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                if let rating = concert.rating {
                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        
                        Text(rating.description)
                            .foregroundStyle(.white)
                    }
                    .font(.headline)
                    
                }
            }
            .padding(8)
            .frame(height: 80, alignment: .bottom)
            .addingGradientBackgroundForText()
        }
        
    }
    
    private var infoSection: some View {
        VStack {
            HStack {
                HStack {
                    if let concertDate = concert.concertDate {
                        Image(systemName: "calendar")
                            .foregroundStyle(.accent)
                        Text(concertDate.formatted(date: .abbreviated, time: .omitted))
                        
                    }
                }
                Spacer()
                
                HStack {
                    if let genre = concert.concertGenre {
                        Image(systemName: "music.note")
                            .foregroundStyle(.accent)
                        Text(genre.rawValue.capitalized)
                    }
                }
            }
            HStack(spacing: 0) {
                if let venue = concert.venue {
                    Image(systemName: "mappin.circle")
                        .foregroundStyle(.accent)
                        .padding(.trailing, 8)
                    Text(venue)
                    
                    if let room = concert.room {
                        Text(", \(room)")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 8)
    }
    
    private var descriptionSection: some View {
        Section {
            if let description = concert.description {
                Text(description)
            }
        } header: {
            Text("Description")
                .font(.callout)
        }

    }
    
    private var mediaSection: some View {
        Section {
            ZStack {
                if let mediaItems = concert.concertMedia {
                    CarouselView(items: mediaItems) { media in
                        HeroCellView(title: "", subtitle: "", imageName: media)
                    }
                }
            }
        } header: {
            Text("Media")
                .font(.callout)
        }
        .padding(.horizontal)
    }
    
    private var additionalSection: some View {
        Section {
            VStack(alignment: .leading) {
//                if let instruments = concert.instruments {
//                    ForEach(instruments.keys, id: \.self) { key in
//                        
//                    }
//                }
                
                if let withUid = concert.withUid {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(withUid, id: \.self) { profile in
                                ImageLoaderView(urlString: profile)
                                    .clipShape(Circle())
                                    .frame(width: 60, height: 60)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            
            
        } header: {
            Text("Addition Info")
                .font(.callout)
        }
    }
}

#Preview {
    ConcertDetailView()
}
