//
//  ProfileView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 04/06/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @FocusState private var isTextFieldFocused: Bool
    var onNavigate: ((Route) -> Void)? = nil
    
    var body: some View {
        ZStack {
            // Header
            headerView
            
            // Content area
            Spacer()
        }
        .padding(.top, 52)
        
        VStack {
            ProfileSearchBar(viewModel: viewModel, isTextFieldFocused: $isTextFieldFocused)
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
        .padding(16)
        .background(.white)
        .shadow(color: .gray.opacity(0.0), radius: 4, x: 0, y: 2)
    }
    
    private var profileImage: some View {
        Image("profile")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 36, height: 36)
            .clipShape(Circle())
    }
    
    private var navigationTabs: some View {
        HStack(alignment: .top, spacing: 30) {
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
    
    private var messageButton: some View {
        Button(action: {
            onNavigate?(.settings)
        }) {
            Image("new message")
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    ProfileView()
}
