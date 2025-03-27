//
//  ProfileView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {

    @State private var showSettingsView: Bool = false
    @State private var currentUser: UserModel?
    @State private var imagePickerPresented = false
    @State private var createConcertPresented = false
    @State private var myConcerts: [ConcertModel] = []
    @State private var isLoading: Bool = true
    
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            
            List {
                profileImageSection
                myConcertsSection
            }
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $createConcertPresented) {
            CreateConcertView()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        .task {
            await loadData()
        }
    }

    private var settingsButton: some View {
        Image(systemName: "gear")
            .font(.headline)
            .foregroundStyle(.accent)
            .anyButton {
                onSettingsButtonPressed()
            }
    }
    
    private var profileImageSection: some View {
        Section {
            ZStack {
                if let loadedImage = viewModel.image {
                    loadedImage
                        .resizable()
                } else if let imageUrl = currentUser?.profileImageUrl {
                    ImageLoaderView(urlString: imageUrl)
                } else {
                    ZStack {
                        Circle()
                            .fill(.accent)
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
            .anyButton {
                onImagePickerButtonPressed()
            }
            .clipShape(Circle())
            .frame(width: 150, height: 150)
            .frame(maxWidth: .infinity)
            .removeListRowFormatting()
        }
    }
    
    private var myConcertsSection: some View {
        Section {
            if myConcerts.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Click + to upload a Concert")
                    }
                }
                .padding(50)
                .frame(maxWidth: .infinity)
                .font(.body)
                .foregroundStyle(.secondary)
                .removeListRowFormatting()
               
                
            } else {
                ForEach(myConcerts, id: \.self) { concert in
                    CustomListCellView(
                        imageName: concert.profileImageName,
                        title: concert.artist,
                        subtitle: concert.subtitle
                    )
                    .anyButton {
                        
                    }
                    .removeListRowFormatting()
                }
                .onDelete { indexSet in
                    onDeleteAvatar(indexSet: indexSet)
                }
            }
            
        } header: {
            HStack(spacing: 0) {
                Text("My Concerts")
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.accent)
                    .font(.title)
                    .anyButton {
                        onCreateConcertButtonPressed()
                    }
            }
        }

    }

    private func onSettingsButtonPressed() {
        showSettingsView = true
    }
    
    private func onImagePickerButtonPressed() {
        imagePickerPresented = true
    }
    
    private func onCreateConcertButtonPressed() {
        createConcertPresented = true
    }
    
    private func onDeleteAvatar(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        myConcerts.remove(at: index)
    }
    
    private func loadData() async {
        try? await Task.sleep(for: .seconds(5))
        isLoading = false
        myConcerts = ConcertModel.mocks
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
}
