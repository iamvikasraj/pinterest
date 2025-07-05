//
//  chatView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 04/06/25.
//

import SwiftUI

struct profileView: View {
    var body: some View {
        ZStack {
            // Header
            headerView
            
            // Content area
            Spacer()
        }
        .padding(.top, 52)
        
        VStack {
            smallSearch()
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
            navigationTab(title: "Pins", underlineWidth: 32)
            navigationTab(title: "Boards", underlineWidth: 0)
            navigationTab(title: "Collage", underlineWidth: 0)
        }
    }
    
    private func navigationTab(title: String, underlineWidth: CGFloat) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
            
            Rectangle()
                .frame(width: underlineWidth, height: 2)
        }
    }
    
    private var messageButton: some View {
        Button(action: {
            // Handle new message action
        }) {
            Image("new message")
                .frame(width: 24, height: 24)
        }
        .opacity(0)
    }
}

struct smallSearch: View {
    @State var isSearching = false
    @State var searchText = ""
    @FocusState private var isTextFieldFocused: Bool
    
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
                isSearching = true
                isTextFieldFocused = true
            }
        }
    }
    
    private var searchIcon: some View {
        Image("search")
            .frame(width: 20, height: 20)
            .offset(x: isSearching ? -20 : 0)
            .opacity(isSearching ? 0 : 1)
            .animation(springAnimation, value: isSearching)
    }
    
    private var searchInput: some View {
        Group {
            if isSearching {
                TextField("Search", text: $searchText)
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
            withAnimation(springAnimation) {
                isSearching.toggle()
                if isSearching {
                    isTextFieldFocused = true
                } else {
                    isTextFieldFocused = false
                    searchText = ""
                }
            }
        }) {
            Image("plus")
                .frame(width: 40, height: 20)
                .rotationEffect(.degrees(isSearching ? 135 : 0))
                .animation(springAnimation, value: isSearching)
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
        .opacity(isSearching ? 1 : 0)
        .offset(y: isSearching ? 0 : 100)
        .animation(springAnimation, value: isSearching)
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

#Preview {
    ContentView()
}
