//
//  CreateConcertViewModel.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 18/03/2025.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
class CreateConcertViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var image: Image?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        guard let uiImage = UIImage(data: data) else { return }
        
        self.image = Image(uiImage: uiImage)
    }
}
