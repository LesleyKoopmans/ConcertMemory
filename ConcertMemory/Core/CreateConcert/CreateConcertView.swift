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
    @State private var isUploadingPost: Bool = false
    @State private var artist: String = ""
    @State private var venue: String = ""
    @State private var description: String = ""
    @State private var imagePickerPresented = false
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
                    dismiss()
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
            }
        }
        .frame(height: 300)
        .anyButton {
            imagePickerPresented = true
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
        .stickyBottomButton()
        .anyButton {
            onUploadPostPressed()
        }
        .disabled(isUploadingPost)
        
        .frame(maxHeight: .infinity, alignment: .bottom)
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
