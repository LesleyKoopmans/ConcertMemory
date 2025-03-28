//
//  CreateConcertView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI
import PhotosUI

struct CreateConcertView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    @Environment(ConcertManager.self) private var concertManager
    
    @State private var isUploadingPost: Bool = false
    @State private var artist: String = ""
    @State private var venue: String = ""
    @State private var room: String = ""
    @State private var description: String = ""
    @State private var concertDate: Date = .now
    @State private var selectedGenre: ConcertGenre = .blues
    @State private var rating: Double = 0
    @State private var imagePickerPresented = false
    @State private var showAlert: AnyAppAlert?
    
    @StateObject var viewModel = CreateConcertViewModel()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    imageSection
                    inputSection
                }
            }
            headerSection
            buttonSection
            
        }
        .ignoresSafeArea()
        .onAppear {
            imagePickerPresented.toggle()
        }
        .toolbar(.hidden, for: .navigationBar)
        .showCustomAlert(alert: $showAlert)
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
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
                    onCancelButtonPressed()
                }
        }
        .frame(height: 150)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var imageSection: some View {
        ZStack {
            if let loadedImage = viewModel.image {
                loadedImage
                    .resizable()
                    .ignoresSafeArea()
            } else {
                ProgressView()
                    .tint(.accent)
            }
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(.accent.opacity(0.2))
        .anyButton {
            imagePickerPresented = true
        }
    }
    
    private var inputSection: some View {
        VStack(spacing: 8) {
            TextField("Artist*", text: $artist)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                TextField("Venue*", text: $venue)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Room", text: $room)
                    .textFieldStyle(.roundedBorder)
            }
            
            TextField("Description*", text: $description, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Text("Date")
                    .foregroundStyle(.accent)
                DatePicker("", selection: $concertDate, displayedComponents: .date)
            }
        
            HStack {
                Text("Genre")
                    .foregroundStyle(.accent)
                Spacer()
                Picker("Genre", selection: $selectedGenre) {
                    ForEach(ConcertGenre.allCases, id: \.self) { genre in
                        Text(genre.rawValue.capitalized)
                            .tag(genre)
                    }
                }
            }
            
            HStack {
                Text("Rating")
                    .foregroundStyle(.accent)
                Slider(value: $rating, in: 0...5, step: 0.5)
                
                HStack(spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("\(rating, specifier: "%.1f")")
                        .frame(width: 30)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var buttonSection: some View {
        AsyncCallToActionButton(
            isLoading: isUploadingPost,
            title: "Upload",
            action: {
                onUploadPostPressed()
            }
        )
        .stickyBottomButton()
        .frame(maxHeight: .infinity, alignment: .bottom)
        .disabled(viewModel.image == nil || artist.isEmpty || venue.isEmpty || description.isEmpty)
    }
    
    private func onCancelButtonPressed() {
        dismiss()
    }
    
    private func onUploadPostPressed() {
        guard let headerImage = viewModel.uiImage else { return }
        
        isUploadingPost = true
        Task {
            do {
                let uid = try authManager.getAuthId()
                
                let concert = ConcertModel(
                    id: UUID().uuidString,
                    artist: artist,
                    description: description,
                    instruments: nil,
                    rating: rating,
                    concertGenre: selectedGenre,
                    venue: venue,
                    room: room,
                    concertHeaderImageUrl: nil,
                    concertMedia: nil,
                    authorId: uid,
                    withUid: nil,
                    concertDate: concertDate,
                    dateCreated: .now
                )
                
                // UPLOAD!
                try await concertManager.createConcert(concert: concert, image: headerImage)
                
                // Dismiss screen
                dismiss()
            } catch {
                showAlert = AnyAppAlert(title: error.localizedDescription)
            }
            isUploadingPost = false
        }
        
    }
}

#Preview {
    CreateConcertView()
        .environment(AuthManager(service: MockAuthService(user: .mock())))
        .environment(ConcertManager(service: MockConcertService()))
}
