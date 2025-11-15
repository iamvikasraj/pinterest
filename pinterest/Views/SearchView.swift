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
    
    var body: some View {
        ZStack(alignment: .top) {
            // Main scrollable content
            ScrollView {
                VStack {
                    // Space for sticky search bar
                    Color.clear.frame(height: 120)
                    
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
                        Color.clear.preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .named("scrollView")).minY
                        )
                    }
                )
            }
            .coordinateSpace(name: "scrollView")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                viewModel.updateScrollOffset(value)
            }
            
            // White background that appears on scroll
            VStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 128)
                    .opacity(viewModel.scrollOffset < -150 ? 0 : 1)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.scrollOffset < -50)
                    .shadow(
                        color: viewModel.scrollOffset < -50 ? .black.opacity(0.1) : .clear,
                        radius: viewModel.scrollOffset < -50 ? 4 : 0,
                        x: 0,
                        y: viewModel.scrollOffset < -50 ? 2 : 0
                    )
                
                Spacer()
            }
            .ignoresSafeArea()
            
            // Search bar on top of everything
            VStack {
                SearchBar()
                    .padding(.top, 70)
                    .padding(.horizontal, 0)
                
                Spacer()
            }
        }
    }
}

#Preview {
    SearchView()
}
