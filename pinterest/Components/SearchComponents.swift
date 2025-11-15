//
//  SearchComponents.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Search Bar
struct SearchBar: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            HStack(alignment: .bottom, spacing: 6) {
                Image("search")
                    .foregroundColor(.clear)
                    .frame(width: 20, height: 20)
                Text("Search Pinterest")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 20, height: 20)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
        }
        .padding(14)
        .frame(width: 378, alignment: .bottomLeading)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(.black, lineWidth: 1)
        )
    }
}

// MARK: - Profile Search Bar
struct ProfileSearchBar: View {
    @ObservedObject var viewModel: ProfileViewModel
    @FocusState.Binding var isTextFieldFocused: Bool
    
    private let springAnimation = Animation.spring(
        response: 0.4,
        dampingFraction: 0.55,
        blendDuration: 0
    )
    
    var body: some View {
        VStack(spacing: 0) {
            searchBar
            searchContent
        }
    }
    
    private var searchBar: some View {
        HStack {
            searchField
            
            Spacer()
            
            toggleButton
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
    }
    
    private var searchField: some View {
        HStack(spacing: 6) {
            searchIcon
            searchInput
        }
        .padding(14)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(.black, lineWidth: 1)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(springAnimation) {
                viewModel.isSearching = true
                isTextFieldFocused = true
            }
        }
    }
    
    private var searchIcon: some View {
        Image("search")
            .frame(width: 20, height: 20)
            .offset(x: viewModel.isSearching ? -20 : 0)
            .opacity(viewModel.isSearching ? 0 : 1)
            .animation(springAnimation, value: viewModel.isSearching)
    }
    
    private var searchInput: some View {
        Group {
            if viewModel.isSearching {
                TextField("Search", text: $viewModel.searchText)
                    .contentTransition(.numericText())
                    .focused($isTextFieldFocused)
                    .font(Font.custom("Inter", size: 16))
                    .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .offset(x: -24)
            } else {
                Text("Search your saved ideas")
                    .contentTransition(.numericText())
                    .font(Font.custom("Inter", size: 16))
                    .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
    }
    
    private var toggleButton: some View {
        Button(action: {
            viewModel.toggleSearch()
            if viewModel.isSearching {
                isTextFieldFocused = true
            } else {
                isTextFieldFocused = false
            }
        }) {
            Image("plus")
                .frame(width: 40, height: 20)
                .rotationEffect(.degrees(viewModel.isSearching ? 135 : 0))
                .animation(springAnimation, value: viewModel.isSearching)
        }
    }
    
    private var searchContent: some View {
        VStack(alignment: .leading, spacing: 34) {
            searchTitle
            recentlyViewedSection
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .opacity(viewModel.isSearching ? 1 : 0)
        .offset(y: viewModel.isSearching ? 0 : 100)
        .animation(springAnimation, value: viewModel.isSearching)
    }
    
    private var searchTitle: some View {
        Text("Search your Pins")
            .font(.system(size: 24, weight: .bold))
    }
    
    private var recentlyViewedSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recently viewed")
                .font(.custom("Inter", size: 15).weight(.medium))
                .foregroundColor(.black)
            
            recentlyViewedGrid
        }
    }
    
    private var recentlyViewedGrid: some View {
        HStack {
            ForEach(0..<4) { item in
                recentlyViewedItem
            }
        }
    }
    
    private var recentlyViewedItem: some View {
        ZStack {
            // Empty placeholder
        }
        .frame(width: 85, height: 114)
        .background(Color(red: 0.28, green: 0.28, blue: 0.28).opacity(0.2))
        .cornerRadius(10)
    }
}

