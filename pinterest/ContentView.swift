//
//  ContentView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    // Main content area with NavigationStack
                    NavigationStack(path: $viewModel.navigationPath) {
                        TabContentView(
                            selectedTab: viewModel.selectedTab,
                            viewModel: viewModel
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .navigationDestination(for: Route.self) { route in
                            destinationView(for: route, viewModel: viewModel)
                        }
                    }
                    
                    // Bottom Navigation
                    BottomNavigationView(viewModel: viewModel)
                }
                
                // Bottom Overlay
                if viewModel.showOverlay {
                    Color.black.opacity(0.8)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.hideOverlay()
                        }
                    
                    BottomOverlayView(
                        isPresented: $viewModel.showOverlay,
                        imageContent: viewModel.selectedImageContent
                    )
                }
            }
        }
        .sheet(isPresented: $viewModel.showCreateBottomSheet) {
            CreateBottomSheet(isPresented: $viewModel.showCreateBottomSheet)
                .presentationDetents([.height(280)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(CornerRadius.xlarge)
                .presentationBackgroundInteraction(.disabled)
        }
        .sheet(isPresented: $viewModel.showPinDetailSheet) {
            PinDetailSheet(
                isPresented: $viewModel.showPinDetailSheet,
                pinId: viewModel.selectedPinId,
                imageName: viewModel.selectedPinImageName,
                sourceFrame: viewModel.sourceFrame
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(CornerRadius.xlarge)
            .presentationBackgroundInteraction(.disabled)
        }
    }
    
    // MARK: - Navigation Destination
    @ViewBuilder
    private func destinationView(for route: Route, viewModel: ContentViewModel) -> some View {
        switch route {
        case .pinDetail(let pinId):
            PinDetailView(pinId: pinId)
        case .boardDetail(let boardId):
            BoardDetailView(boardId: boardId)
        case .userProfile(let userId):
            UserProfileDetailView(userId: userId)
        case .messageDetail(let messageId):
            MessageDetailView(messageId: messageId)
        case .settings:
            SettingsView()
        case .editProfile:
            EditProfileView()
        case .searchResults(let query):
            SearchResultsView(query: query)
        }
    }
}


// MARK: - Tab Content Views
struct TabContentView: View {
    let selectedTab: Tab
    let viewModel: ContentViewModel
    
    var body: some View {
        switch selectedTab {
        case .home:
            HomeView(viewModel: viewModel)
        case .search:
            SearchView(onNavigate: { route in
                viewModel.navigate(to: route)
            })
        case .create:
            CreateView()
        case .chat:
            ChatView(onNavigate: { route in
                viewModel.navigate(to: route)
            })
        case .profile:
            ProfileView(
                onNavigate: { route in
                    viewModel.navigate(to: route)
                },
                contentViewModel: viewModel
            )
        }
    }
}


#Preview {
    ContentView()
}
