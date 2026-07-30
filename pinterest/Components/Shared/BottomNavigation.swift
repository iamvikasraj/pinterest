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
        HStack(spacing: Spacing.md) {
            // Home Tab
            FloatingNavButton(isSelected: viewModel.selectedTab == .home) {
                Image(viewModel.selectedTab == .home ? "home-active" : "home")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
            } action: {
                viewModel.selectTab(.home)
            }

            // Search Tab
            FloatingNavButton(isSelected: viewModel.selectedTab == .search) {
                Image(viewModel.selectedTab == .search ? "search-active" : "search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
            } action: {
                viewModel.selectTab(.search)
            }

            // Profile Tab
            FloatingNavButton(isSelected: viewModel.selectedTab == .profile) {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 32, height: 32)
                    .background(Color(red: 0.96, green: 0, blue: 0))
                    .clipShape(Circle())
            } action: {
                viewModel.selectTab(.profile)
            }
        }
    }
}

// MARK: - Floating Nav Button
struct FloatingNavButton<Content: View>: View {
    let isSelected: Bool
    @ViewBuilder let content: Content
    let action: () -> Void

    var body: some View {
        content
            .frame(width: 54, height: 54)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 4)
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .onTapGesture {
                action()
            }
    }
}
