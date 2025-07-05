//
//  ContentView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home
        case search
        case create
        case chat
        case profile
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Header
                
                // Main content area
                ScrollView {
                    TabContentView(selectedTab: selectedTab)
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea(.all)
                
                // Bottom Navigation
                BottomNavigationView(selectedTab: $selectedTab)
            }
        }
    }
}

// MARK: - Tab Content Views
struct TabContentView: View {
    let selectedTab: ContentView.Tab
    
    var body: some View {
        switch selectedTab {
        case .home:
            HomeView()
        case .search:
            searchView()
        case .create:
            CreateView()
        case .chat:
            chatView()
        case .profile:
            profileView()
        }
    }
}

struct HomeView: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 0) {
            oneCard(content: "one")
            oneCard(content: "two")
            oneCard(content: "three")
            oneCard(content: "fourth")
            oneCard(content: "fifth")
            oneCard(content: "one")
            oneCard(content: "two")
            oneCard(content: "three")
            oneCard(content: "fourth")
            oneCard(content: "fifth")
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 80)
    }
}

struct CreateView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Create")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .padding(.vertical, 80)
    }
}

// MARK: - Bottom Navigation
struct BottomNavigationView: View {
    @Binding var selectedTab: ContentView.Tab
    
    var body: some View {
        HStack(alignment: .center) {
            // Home Tab
            Image(selectedTab == .home ? "home-active" : "home")
                .onTapGesture {
                    selectedTab = .home
                }
            Spacer()
            
            // Search Tab
            Image(selectedTab == .search ? "search-active" : "search")
                .onTapGesture {
                    selectedTab = .search
                }
            Spacer()
            
            // Create Tab
            Image(selectedTab == .create ? "start-active" : "start")
                .onTapGesture {
                    selectedTab = .create
                }
            Spacer()
            
            // Chat Tab
            Image(selectedTab == .chat ? "chat-active" : "chat")
                .onTapGesture {
                    selectedTab = .chat
                }
            Spacer()
            
            // Profile Tab
            user()
                .onTapGesture {
                    selectedTab = .profile
                }
        }
        .padding(.horizontal, 28)
        .padding(.top, 10)
        .padding(.bottom, 0)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.white)
        .shadow(color: .gray.opacity(0.1), radius: 10, x: 0, y: -2)
    }
}

// MARK: - Card Components
struct oneCard: View {
    
    let content: String
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            VStack(alignment: .leading, spacing: 10) {
                Image(content)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(maxWidth: 190, alignment: .topLeading)
            .background(Color(red: 0.73, green: 0.73, blue: 0.73))
            .cornerRadius(16)
            .clipped()
            
            VStack(alignment: .leading, spacing: 10) {
                Image("more")
            }
        }
        .padding(0)
        .frame(width: 191, alignment: .bottomTrailing)
    }
}

struct user: View {
    var body: some View {
        Image("profile")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 24, height: 24)
            .background(Color(red: 0.96, green: 0, blue: 0))
            .cornerRadius(20)
    }
}

#Preview {
    ContentView()
}
