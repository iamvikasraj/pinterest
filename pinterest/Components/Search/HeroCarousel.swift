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
    
    var body: some View {
        // Guard against empty carousel items
        if viewModel.carouselItems.isEmpty {
            EmptyView()
        } else {
            VStack(spacing: 0) {
                // Main Carousel Container - Edge to Edge
                ZStack {
                    // Background Images (behind the text)
                    ForEach(0..<viewModel.carouselItems.count, id: \.self) { index in
                        ZStack {
                            // Background Image
                            Image(viewModel.carouselItems[index].backgroundImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 360)
                                .clipped()
                                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: viewModel.currentCarouselPage)
                                .background(.ultraThinMaterial)
                            
                            Rectangle()
                                .foregroundColor(.black).opacity(0.8)
                        }
                        .scaleEffect(viewModel.currentCarouselPage == index ? 1.0 : 1.0)
                        .opacity(viewModel.currentCarouselPage == index ? 1.0 : 0.0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: viewModel.currentCarouselPage)
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
                        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: viewModel.currentCarouselPage)
                    }
                }
                .frame(height: 340)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                viewModel.navigateCarousel(direction: .previous)
                            } else if value.translation.width < -threshold {
                                viewModel.navigateCarousel(direction: .next)
                            }
                        }
                )
                
                // Custom Page Indicator
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.carouselItems.count, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(viewModel.currentCarouselPage == index ? .black : Color(red: 0.78, green: 0.78, blue: 0.76))
                            .scaleEffect(viewModel.currentCarouselPage == index ? 1.4 : 1.0)
                            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: viewModel.currentCarouselPage)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    viewModel.setCarouselPage(index)
                                }
                            }
                    }
                }
                .padding(.vertical, 20)
            }
        }
    }
}
