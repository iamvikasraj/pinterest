//
//  ContentView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedTab: Tab = .home
    @State private var showOverlay = false
    @State private var selectedImageContent = ""
    
    enum Tab {
        case home
        case search
        case create
        case chat
        case profile
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    // Header
                    
                    // Main content area
                    ScrollView {
                        TabContentView(selectedTab: selectedTab, showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
                    }
                    .scrollIndicators(.hidden)
                    .ignoresSafeArea(.all)
                    
                    // Bottom Navigation
                    BottomNavigationView(selectedTab: $selectedTab)
                }
                
                // Bottom Overlay
                if showOverlay {
                    Color.black.opacity(0.8)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showOverlay = false
                        }
                    
                    BottomOverlayView(
                        isPresented: $showOverlay,
                        imageContent: selectedImageContent
                    )
                }
            }
        }
    }
}

// MARK: - Bottom Overlay View
struct BottomOverlayView: View {
    @Binding var isPresented: Bool
    let imageContent: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Bottom Sheet
                VStack(spacing: 0) {
                    // Handle bar
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 6)
                        .padding(.top, 12)
                    
                    // Image positioned at the top with half outside effect
                    VStack {
                        Image(imageContent)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipped()
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                            .offset(y: -40) // Half outside the sheet
                    }
                    .padding(.top, 20)
                    
                    // Options section
                    VStack(spacing: 0) {
                        OverlayOptionRow(iconName: "square.and.arrow.up", title: "Share")
                        OverlayOptionRow(iconName: "bookmark", title: "Save")
                        OverlayOptionRow(iconName: "eye.slash", title: "Hide")
                        OverlayOptionRow(iconName: "square.and.arrow.down", title: "Download image")
                        OverlayOptionRow(iconName: "xmark.circle", title: "Stop seeing similar pins")
                        OverlayOptionRow(iconName: "exclamationmark.triangle", title: "Report")
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -5)
                .offset(y: isPresented ? 0 : geometry.size.height + 100)
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0), value: isPresented)
            }
            .ignoresSafeArea(.all)
        }
    }
}
// MARK: - Overlay Option Row
struct OverlayOptionRow: View {
    let iconName: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .frame(width: 16, height: 16)
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.vertical, 12)
        .contentShape(Rectangle())
        .onTapGesture {
            // Handle option tap
            print("Tapped: \(title)")
        }
    }
}

// MARK: - Tab Content Views
struct TabContentView: View {
    let selectedTab: ContentView.Tab
    @Binding var showOverlay: Bool
    @Binding var selectedImageContent: String
    
    var body: some View {
        switch selectedTab {
        case .home:
            HomeView(showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
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
    @Binding var showOverlay: Bool
    @Binding var selectedImageContent: String
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 0) {
            oneCard(content: "one", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "two", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "three", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "fourth", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "fifth", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "one", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "two", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "three", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "fourth", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
            oneCard(content: "fifth", showOverlay: $showOverlay, selectedImageContent: $selectedImageContent)
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
    @Binding var showOverlay: Bool
    @Binding var selectedImageContent: String
    
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
                    .onTapGesture {
                        selectedImageContent = content
                        showOverlay = true
                    }
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

// MARK: - Extensions
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ContentView()
}
