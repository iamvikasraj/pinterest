//
//  SearchView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    var onNavigate: ((Route) -> Void)? = nil
    @State private var scrollOffset: CGFloat = 0
    @State private var initialOffset: CGFloat?
    
    var body: some View {
        GeometryReader { outerGeometry in
            ZStack(alignment: .top) {
                // Main scrollable content
                ScrollView {
                    VStack(spacing: 0) {
                        HeroCarousel(viewModel: viewModel)
                        
                        FeaturedBoardView(
                            title: "Explore featured boards",
                            bigTitle: "Ideas you might like",
                            boards: viewModel.featuredBoards,
                            onBoardTapped: { boardId in
                                onNavigate?(.boardDetail(boardId: boardId))
                            }
                        )
                        
                        ForEach(viewModel.searchSections) { section in
                            SearchSectionView(
                                title: section.title,
                                bigTitle: section.bigTitle,
                                images: section.images
                            )
                        }
                    }
                    .padding(.bottom, 180)
                    .background(
                        GeometryReader { geometry in
                            let offset = geometry.frame(in: .global).minY
                            Color.clear
                                .preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: offset
                                )
                        }
                    )
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { newValue in
                    // Store initial offset on first read
                    if initialOffset == nil {
                        initialOffset = newValue
                        scrollOffset = 0
                        return
                    }
                    
                    // Calculate relative scroll (how much we've scrolled down)
                    guard let initial = initialOffset else { return }
                    let relativeScroll = initial - newValue
                    scrollOffset = relativeScroll
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea()
                
                // Search bar overlay with animated white background
                VStack(spacing: 0) {
                    SearchBar()
                        .padding(.horizontal, Spacing.lg)
                        .padding(.vertical, Spacing.md)
                }
                .frame(maxWidth: .infinity)
                .background(
                    // White background that fades in when scrolling
                    Color.white
                        .opacity(scrollOffset >= 250 ? 1 : 0)
                )
                
            }
        }
    }
}

#Preview("Search View") {
    SearchView()
}

#Preview("Search View - Dark Mode") {
    SearchView()
        .preferredColorScheme(.dark)
}

