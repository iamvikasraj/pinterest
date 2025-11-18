//
//  BottomNavigation.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Bottom Navigation
struct BottomNavigationView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            // Home Tab
            TabButton(
                imageName: viewModel.selectedTab == .home ? "home-active" : "home",
                isSelected: viewModel.selectedTab == .home,
                action: { viewModel.selectTab(.home) }
            )
            Spacer()
            
            // Search Tab
            TabButton(
                imageName: viewModel.selectedTab == .search ? "search-active" : "search",
                isSelected: viewModel.selectedTab == .search,
                action: { viewModel.selectTab(.search) }
            )
            Spacer()
            
            // Create Tab
            TabButton(
                imageName: viewModel.selectedTab == .create ? "start-active" : "start",
                isSelected: viewModel.selectedTab == .create,
                action: { viewModel.showCreateSheet() }
            )
            Spacer()
            
            // Chat Tab
            TabButton(
                imageName: viewModel.selectedTab == .chat ? "chat-active" : "chat",
                isSelected: viewModel.selectedTab == .chat,
                action: { viewModel.selectTab(.chat) }
            )
            Spacer()
            
            // Profile Tab
            UserProfileImage()
                .onTapGesture {
                    viewModel.selectTab(.profile)
                }
        }
        .padding(.horizontal, 60)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.white)
        .shadow(color: .gray.opacity(0.1), radius: 10, x: 0, y: -2)
    }
}

// MARK: - Tab Button
struct TabButton: View {
    let imageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 28, height: 28)
            .onTapGesture {
                action()
            }
    }
}


