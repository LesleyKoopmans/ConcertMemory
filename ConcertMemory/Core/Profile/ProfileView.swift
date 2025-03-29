//
//  ProfileView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @Environment(UserManager.self) private var userManager
    @Environment(AuthManager.self) private var authManager
    @Environment(ConcertManager.self) private var concertManager
    
    @State private var showSettingsView: Bool = false
    @State private var currentUser: UserModel?
    @State private var imagePickerPresented = false
    @State private var createConcertPresented = false
    @State private var myConcerts: [ConcertModel] = []
    @State private var isLoading: Bool = true
    @State private var path: [NavigationPathOption] = []
    
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack(path: $path) {
            
            List {
                profileImageSection
                myConcertsSection
            }
                .navigationTitle("Profile")
                .navigationDestinationForCoreModule(path: $path)
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
        .onChange(of: viewModel.uiImage) { _, image in
            Task {
                do {
                    try await userManager.updateProfileImageUrl(user: currentUser!, image: viewModel.uiImage!)
                } catch {
                    
                }
            }
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
                } else {
                    ProfileImageView(imageName: currentUser?.profileImageUrl ?? nil) {
                        onImagePickerButtonPressed()
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
                        imageName: concert.concertHeaderImageUrl,
                        title: concert.artist
                    )
                    .anyButton {
                        onConcertPressed(concert: concert)
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
    
    private func loadData() async {
        self.currentUser = userManager.currentUser
        
        do {
            let uid = try authManager.getAuthId()
            myConcerts = try await concertManager.getConcertsForAuthor(userId: uid)
            
        } catch {
            print("Failed to load user concerts: \(error)")
        }
        
        isLoading = false
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
    
    private func onConcertPressed(concert: ConcertModel) {
        path.append(.concert(concert: concert, concertId: concert.id))
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
        .environment(UserManager(services: MockUserServices(user: .mock)))
        .environment(AuthManager(service: MockAuthService(user: .mock())))
        .environment(ConcertManager(service: MockConcertService()))
}
