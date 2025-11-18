//
//  ProfileView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 04/06/25.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @FocusState private var isTextFieldFocused: Bool
    var onNavigate: ((Route) -> Void)? = nil
    var contentViewModel: ContentViewModel? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            // Search Bar
            ProfileSearchBar(viewModel: viewModel, isTextFieldFocused: $isTextFieldFocused)
                .padding(.horizontal, Spacing.lg)
                .padding(.vertical, Spacing.md)
                .background(.white)
            
            // Filter Bar
            filterBar
                .padding(.horizontal, Spacing.lg)
                .padding(.vertical, Spacing.sm)
                .background(.white)
            
            // Content Area
            ScrollView {
                tabContent
                    .padding(.horizontal, Spacing.xs)
                    .padding(.top, Spacing.md)
                    .padding(.bottom, 100) // Space for bottom navigation
            }
            .scrollIndicators(.hidden)
        }
        .background(.white)
    }
    
    private var headerView: some View {
        HStack {
            profileImage
            
            Spacer()
            
            navigationTabs
            
            Spacer()
            
            messageButton
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.vertical, Spacing.md)
        .background(.white)
    }
    
    private var profileImage: some View {
        Image("profile")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
    
    private var navigationTabs: some View {
        HStack(spacing: Spacing.xxl) {
            ForEach(ProfileViewModel.ProfileTab.allCases, id: \.self) { tab in
                NavigationTab(
                    title: tab.rawValue,
                    isSelected: viewModel.selectedTab == tab,
                    onTap: {
                        viewModel.selectTab(tab)
                    }
                )
            }
        }
    }
    
    private var filterBar: some View {
        HStack(spacing: Spacing.md) {
            // Grid filter button
            Button(action: {
                print("Grid filter tapped")
            }) {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "square.grid.3x3")
                        .font(.system(size: 16))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                }
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.sm)
                .background(AppColors.backgroundSecondary)
                .cornerRadius(CornerRadius.medium)
            }
            
            // Favorites button
            Button(action: {
                print("Favorites tapped")
            }) {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                    Text("Favorites")
                        .font(Typography.Caption.large)
                }
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.sm)
                .background(AppColors.backgroundSecondary)
                .cornerRadius(CornerRadius.medium)
            }
            
            // Created by you button
            Button(action: {
                print("Created by you tapped")
            }) {
                Text("Created by you")
                    .font(Typography.Caption.large)
                    .foregroundColor(AppColors.textPrimary)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.sm)
                    .background(AppColors.backgroundSecondary)
                    .cornerRadius(CornerRadius.medium)
            }
            
            Spacer()
        }
    }
    
    private var messageButton: some View {
        Button(action: {
            onNavigate?(.settings)
        }) {
            Image("new message")
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
        }
    }
    
    @ViewBuilder
    private var tabContent: some View {
        switch viewModel.selectedTab {
        case .pins:
            pinsContent
        case .boards:
            boardsContent
        case .collage:
            collageContent
        }
    }
    
    private var pinsContent: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: Spacing.xs),
            GridItem(.flexible(), spacing: Spacing.xs),
            GridItem(.flexible(), spacing: Spacing.xs)
        ], spacing: Spacing.xs) {
            // Sample pins with labels
            ForEach(samplePins, id: \.id) { pin in
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    let imageSize = getImageSize(named: pin.imageName)
                    let aspectRatio = imageSize.height / imageSize.width
                    
                    Image(pin.imageName)
                        .resizable()
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(CornerRadius.medium)
                    
                    Text(pin.title)
                        .font(Typography.Caption.large)
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    contentViewModel?.showPinDetail(pinId: "\(pin.id)", imageName: pin.imageName, sourceFrame: .zero)
                }
            }
        }
    }
    
    private func getImageSize(named: String) -> CGSize {
        guard let image = UIImage(named: named) else {
            return CGSize(width: 1, height: 1.5) // Default aspect ratio
        }
        return image.size
    }
    
    private var samplePins: [(id: Int, imageName: String, title: String)] {
        [
            (1, "one", "Skoda Octavia A7 fl"),
            (2, "two", "Skoda Octavia"),
            (3, "three", "Lowstyle Skoda O..."),
            (4, "fourth", "Skoda Octavia RS..."),
            (5, "fifth", "skoda octavia"),
            (6, "one", "Forum"),
            (7, "two", "Skoda Octavia"),
            (8, "three", "Skoda Octavia"),
            (9, "fourth", "Skoda Octavia")
        ]
    }
    
    private var boardsContent: some View {
        VStack(spacing: Spacing.lg) {
            // Placeholder boards
            ForEach(0..<3) { _ in
                HStack(spacing: Spacing.md) {
                    RoundedRectangle(cornerRadius: CornerRadius.medium)
                        .fill(AppColors.backgroundSecondary)
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppColors.backgroundTertiary)
                            .frame(height: 16)
                            .frame(maxWidth: 150)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppColors.backgroundSecondary)
                            .frame(height: 12)
                            .frame(maxWidth: 100)
                    }
                    
                    Spacer()
                }
                .padding(Spacing.md)
                .background(.white)
                .cornerRadius(CornerRadius.large)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.large)
                        .stroke(AppColors.borderGray, lineWidth: 1)
                )
            }
        }
    }
    
    private var collageContent: some View {
        VStack(spacing: Spacing.md) {
            Text("Collage View")
                .font(Typography.Semantic.sectionTitle)
                .foregroundColor(AppColors.textSecondary)
                .padding(.vertical, Spacing.xxl)
        }
    }
}

#Preview("Profile View") {
    ProfileView()
}

#Preview("Profile View - Dark Mode") {
    ProfileView()
        .preferredColorScheme(.dark)
}
