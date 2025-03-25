//
//  TabBarView.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//

import SwiftUI

struct TabBarView: View {
    
    @State var isPresenting = false
    @State private var selectedItem = 1
    @State private var oldSelectedItem = 1
    
    var body: some View {
        TabView(selection: $selectedItem) {
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "music.note")
                }
                .tag(1)

            Text("")
                .tabItem {
                    Label("New", systemImage: "plus.app.fill")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .onChange(of: selectedItem) { oldValue, newValue in
            if 2 == selectedItem {
                self.isPresenting = true
                self.selectedItem = self.oldSelectedItem
            }
        }
        .fullScreenCover(isPresented: $isPresenting) {
            CreateConcertView()
        }
    }
}

#Preview {
    TabBarView()
}
