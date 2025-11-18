//
//  HeroCarousel.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Hero Carousel
struct HeroCarousel: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var previousPage: Int = 0
    
    var body: some View {
        // Guard against empty carousel items
        Group {
            if viewModel.carouselItems.isEmpty {
                EmptyView()
            } else {
                VStack(spacing: 0) {
                    // Main Carousel Container - Edge to Edge
                    GeometryReader { geometry in
                        ZStack {
                            // Background Images (behind the text) - Sliding horizontally
                            ForEach(0..<viewModel.carouselItems.count, id: \.self) { index in
                                ZStack {
                                    // Background Image
                                    Image(viewModel.carouselItems[index].backgroundImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity, maxHeight: 360)
                                        .clipped()
                                        .background(.ultraThinMaterial)
                                    
                                    Rectangle()
                                        .foregroundColor(.black).opacity(0.4)
                                }
                                .frame(width: geometry.size.width)
                                .offset(x: calculateOffset(for: index, containerWidth: geometry.size.width))
                                .opacity(calculateOpacity(for: index))
                                .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0), value: viewModel.currentCarouselPage)
                                .zIndex(viewModel.currentCarouselPage == index ? 1 : 0)
                            }
                        
                            // Fixed Text Content (stays in same position)
                            if viewModel.currentCarouselPage < viewModel.carouselItems.count {
                                VStack(spacing: 8) {
                                    Text(viewModel.carouselItems[viewModel.currentCarouselPage].title)
                                        .font(Typography.Semantic.carouselTitle)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                    
                                    Text(viewModel.carouselItems[viewModel.currentCarouselPage].subtitle)
                                        .font(Typography.Semantic.carouselSubtitle)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 20)
                                .padding(.top, 60)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .contentTransition(.numericText())
                                .shadow(radius: 20)
                                .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0), value: viewModel.currentCarouselPage)
                                .zIndex(2)
                            }
                        }
                    }
                    .frame(height: 340)
                    .clipped()
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    previousPage = viewModel.currentCarouselPage
                                    viewModel.navigateCarousel(direction: .previous)
                                } else if value.translation.width < -threshold {
                                    previousPage = viewModel.currentCarouselPage
                                    viewModel.navigateCarousel(direction: .next)
                                }
                            }
                    )
                    .onChange(of: viewModel.currentCarouselPage) { oldValue, newValue in
                        if oldValue != newValue {
                            previousPage = oldValue
                        }
                    }
                    
                    // Custom Page Indicator
                    HStack(spacing: 6) {
                        ForEach(0..<viewModel.carouselItems.count, id: \.self) { index in
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(viewModel.currentCarouselPage == index ? .black : Color(red: 0.78, green: 0.78, blue: 0.76))
                                .scaleEffect(viewModel.currentCarouselPage == index ? 1.0 : 1.0)
                                .animation(.spring(response: 0.9, dampingFraction: 0.7), value: viewModel.currentCarouselPage)
                                .onTapGesture {
                                    previousPage = viewModel.currentCarouselPage
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0)) {
                                        viewModel.setCarouselPage(index)
                                    }
                                }
                        }
                    }
                    .padding(.vertical, 10)
                }
                .onAppear {
                    previousPage = viewModel.currentCarouselPage
                }
            }
        }
    }
    
    private func calculateOffset(for index: Int, containerWidth: CGFloat) -> CGFloat {
        let currentPage = viewModel.currentCarouselPage
        let diff = index - currentPage
        
        if diff == 0 {
            return 0
        } else {
            // Calculate offset based on difference: positive diff means right side, negative means left
            return CGFloat(diff) * containerWidth
        }
    }
    
    private func calculateOpacity(for index: Int) -> Double {
        let currentPage = viewModel.currentCarouselPage
        let diff = abs(index - currentPage)
        
        // Only show current page and adjacent pages (for smooth transitions)
        if diff <= 1 {
            return 1.0
        } else {
            return 0.0
        }
    }
}


#Preview {
    HeroCarousel(viewModel: SearchViewModel())
}
