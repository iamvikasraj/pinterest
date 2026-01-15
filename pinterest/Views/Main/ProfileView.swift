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
    @State private var transitionDirection: TransitionDirection = .none
    @Namespace private var underlineNamespace
    var onNavigate: ((Route) -> Void)? = nil
    var contentViewModel: ContentViewModel? = nil
    
    enum TransitionDirection {
        case forward, backward, none
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header (fixed at top)
            headerView
            
            // Content Area with TabView paging
            TabView(selection: $viewModel.selectedTab) {
                ForEach(ProfileViewModel.ProfileTab.allCases, id: \.self) { tab in
                    tabContent(for: tab)
                        .tag(tab)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .disabled(contentViewModel?.showPinDetailSheet ?? false)
            .onChange(of: viewModel.selectedTab) { oldValue, newValue in
                // Determine direction based on old and new tab
                if let oldIndex = ProfileViewModel.ProfileTab.allCases.firstIndex(of: oldValue),
                   let newIndex = ProfileViewModel.ProfileTab.allCases.firstIndex(of: newValue) {
                    transitionDirection = newIndex > oldIndex ? .forward : .backward
                }
            }
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
                        // Determine direction based on current and new tab
                        if let currentIndex = ProfileViewModel.ProfileTab.allCases.firstIndex(of: viewModel.selectedTab),
                           let newIndex = ProfileViewModel.ProfileTab.allCases.firstIndex(of: tab) {
                            transitionDirection = newIndex > currentIndex ? .forward : .backward
                        }
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.selectTab(tab)
                        }
                    },
                    namespace: underlineNamespace,
                    tabId: tab.rawValue
                )
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.selectedTab)
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
    private func tabContent(for tab: ProfileViewModel.ProfileTab) -> some View {
        ScrollView {
            Group {
                switch tab {
                case .pins:
                    pinsContent
                case .boards:
                    boardsContent
                case .collage:
                    collageContent
                }
            }
            .padding(.bottom, 100) // Space for bottom navigation
        }
        .scrollIndicators(.hidden)
    }
    
    private var searchAndFilterSection: some View {
        VStack(spacing: 0) {
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
        }
    }
    
    private var pinsContent: some View {
        VStack(spacing: 0) {
            // Search and Filter Section
            searchAndFilterSection
            
            // Pins Grid
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: Spacing.xs),
                GridItem(.flexible(), spacing: Spacing.xs),
                GridItem(.flexible(), spacing: Spacing.xs)
            ], spacing: Spacing.xs) {
                // Sample pins with labels
                ForEach(samplePins, id: \.id) { pin in
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        if !pin.imageName.isEmpty {
                            let imageSize = getImageSize(named: pin.imageName)
                            let aspectRatio = imageSize.height / imageSize.width
                            
                            Image(pin.imageName)
                                .resizable()
                                .aspectRatio(aspectRatio, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .cornerRadius(CornerRadius.medium)
                        } else {
                            Rectangle()
                                .fill(AppColors.backgroundSecondary)
                                .aspectRatio(0.75, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(CornerRadius.medium)
                        }
                        
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
            .padding(.horizontal, Spacing.xs)
            .padding(.top, Spacing.md)
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
        VStack(spacing: 0) {
            // Search and Filter Section
            searchAndFilterSection
            
            // Tags Section
            HStack(spacing: Spacing.md) {
                // Group tag
                Button(action: {
                    print("Group tapped")
                }) {
                    Text("Group")
                        .font(Typography.Caption.large)
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(AppColors.backgroundSecondary)
                        .cornerRadius(CornerRadius.medium)
                }
                
                // Secret tag
                Button(action: {
                    print("Secret tapped")
                }) {
                    Text("Secret")
                        .font(Typography.Caption.large)
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(AppColors.backgroundSecondary)
                        .cornerRadius(CornerRadius.medium)
                }
                
                // Archived tag
                Button(action: {
                    print("Archived tapped")
                }) {
                    Text("Archived")
                        .font(Typography.Caption.large)
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(AppColors.backgroundSecondary)
                        .cornerRadius(CornerRadius.medium)
                }
                
                Spacer()
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.vertical, Spacing.md)
            .background(.white)
            
            // Boards List
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
            .padding(.horizontal, Spacing.lg)
            .padding(.top, Spacing.md)
        }
    }
    
    private var collageContent: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: Spacing.xl) {
                // Circular illustration with colorful shapes and scissors
                ZStack {
                    // Circular background
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.9, green: 0.95, blue: 1.0), // Light blue
                                    Color(red: 1.0, green: 0.95, blue: 0.9)  // Light orange
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 200, height: 200)
                    
                    // Colorful abstract shapes (paper cutouts)
                    ZStack {
                        // Light blue shape
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 0.7, green: 0.85, blue: 1.0))
                            .frame(width: 60, height: 80)
                            .rotationEffect(.degrees(-15))
                            .offset(x: -40, y: -20)
                        
                        // Orange shape
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(red: 1.0, green: 0.6, blue: 0.3))
                            .frame(width: 50, height: 70)
                            .rotationEffect(.degrees(25))
                            .offset(x: 30, y: -30)
                        
                        // Red shape
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(red: 1.0, green: 0.3, blue: 0.3))
                            .frame(width: 45, height: 65)
                            .rotationEffect(.degrees(-20))
                            .offset(x: -20, y: 30)
                        
                        // Pink shape
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 1.0, green: 0.7, blue: 0.8))
                            .frame(width: 40, height: 55)
                            .rotationEffect(.degrees(35))
                            .offset(x: 35, y: 25)
                        
                        // Light purple shape
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.9, green: 0.7, blue: 1.0))
                            .frame(width: 50, height: 60)
                            .rotationEffect(.degrees(-10))
                            .offset(x: 10, y: -40)
                    }
                    
                    // Blue scissors overlay
                    Image(systemName: "scissors")
                        .font(.system(size: 50, weight: .medium))
                        .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
                        .offset(x: 30, y: 10)
                        .rotationEffect(.degrees(15))
                }
                .frame(width: 200, height: 200)
                
                // Heading
                Text("Make your first collage")
                    .font(Typography.Semantic.searchTitle)
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                
                // Description
                Text("Snip-and-paste the best parts of your favorite Pins to create something completely new.")
                    .font(Typography.Semantic.cardBody)
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.xl * 2)
                
                // Create collage button
                Button(action: {
                    print("Create collage tapped")
                }) {
                    Text("Create collage")
                        .font(Typography.Semantic.navItem)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.md)
                        .background(AppColors.pinterestRed)
                        .cornerRadius(CornerRadius.large)
                }
                .padding(.horizontal, Spacing.xl * 2)
                .padding(.top, Spacing.md)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview("Profile View") {
    ProfileView()
}

#Preview("Profile View - Dark Mode") {
    ProfileView()
        .preferredColorScheme(.dark)
}
