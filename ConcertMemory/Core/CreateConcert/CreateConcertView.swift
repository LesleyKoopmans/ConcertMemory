//
//  CreateConcertView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI
import PhotosUI

struct CreateConcertView: View {

    @State private var isUploadingPost: Bool = false
    @State private var artist: String = ""
    @State private var venue: String = ""
    @State private var description: String = ""
    @State private var imagePickerPresented = false
    @StateObject var viewModel = CreateConcertViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                imageSection
                
                inputSection
                
                Spacer()
                
                buttonSection
                
            }
            .onAppear {
                imagePickerPresented.toggle()
            }
            
            .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)

        }
    }
    
    private var imageSection: some View {
        ZStack {
            if let loadedImage = viewModel.image {
                loadedImage
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 300)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.accent)
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
                .frame(width: 200, height: 200)
                .anyButton(.press) {
                    
                }
            }
        }
    }
    
    private var inputSection: some View {
        VStack(spacing: 8) {
            TextField("Artist", text: $artist)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            TextField("Venue", text: $venue)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            TextField("Description", text: $description, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
        }
    }
    
    private var buttonSection: some View {
        ZStack {
            if isUploadingPost {
                ProgressView()
                    .tint(.white)
            } else {
                Text("Finish")
            }
        }
        .callToActionButton()
        .anyButton(.press, action: {
            onUploadPostPressed()
        })
        .disabled(isUploadingPost)
    }
    
    func onUploadPostPressed() {
        isUploadingPost = true
        
        Task {
            try await Task.sleep(for: .seconds(3))
            isUploadingPost = false
        }
    }
}

#Preview {
    CreateConcertView()
}
