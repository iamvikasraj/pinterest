//
//  searchView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct searchView: View {
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            // Main scrollable content
            ScrollView {
                VStack {
                    // Space for sticky search bar
                    Color.clear.frame(height: 120)
                    
                    HeroCarousel()
                    featuredBoard(title: "Explore featured boards", bigtitle: "Ideas you might like")
                    searchSection(title: "Popular on Pinterest", bigtitle: "Hunter 350", images: ["search-1", "search-2", "search-3", "search-4"])
                    searchSection(title: "Ideas for you", bigtitle: "Furniture graphics", images: ["fg-1", "fg-2", "fg-3", "fg-4"])
                    searchSection(title: "Ideas for you", bigtitle: "Mobile Design", images: ["md-1", "md-2", "md-3", "md-4"])
                    searchSection(title: "Ideas for you", bigtitle: "Gents shoes", images: ["gs-1", "gs-2", "gs-3", "gs-4"])
                    searchSection(title: "Popular on Pinterest", bigtitle: "Cars", images: ["cars-1", "cars-2", "cars-3", "cars-4"])
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
                scrollOffset = value
            }
            
            // White background that appears on scroll
            VStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 128) // Covers the search bar area
                    .opacity(scrollOffset < -150 ? 0 : 1) // Show when scrolled
                    .animation(.easeInOut(duration: 0.2), value: scrollOffset < -50)
                    .shadow(
                        color: scrollOffset < -50 ? .black.opacity(0.1) : .clear,
                        radius: scrollOffset < -50 ? 4 : 0,
                        x: 0,
                        y: scrollOffset < -50 ? 2 : 0
                    )
                
                Spacer()
            }
            .ignoresSafeArea()
            
            // Search bar on top of everything
            VStack {
                searchBar()
                    .padding(.top, 70)
                    .padding(.horizontal, 0)
                
                Spacer()
            }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
#Preview {
    ContentView()
}

struct searchBar: View {
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


struct CarouselItem {
    let title: String
    let subtitle: String
    let backgroundImage: String // SF Symbol or image name
    let id = UUID()
}

struct HeroCarousel: View {
    @State private var currentPage = 0
    
    let carouselItems = [
        CarouselItem(title: "A piece of cake", subtitle: "Anyone can bake recipes", backgroundImage: "cover-1"),
        CarouselItem(title: "Uplifting quotes", subtitle: "Words to hear today", backgroundImage: "cover-2"),
        CarouselItem(title: "Stand out", subtitle: "Backpack styling for men", backgroundImage: "cover-3"),
        CarouselItem(title: "A touch of cute", subtitle: "Pink room decor of your dreams", backgroundImage: "cover-4"),
        CarouselItem(title: "Casual chic", subtitle: "Kolhapuris for men & women", backgroundImage: "cover-5")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Carousel Container - Edge to Edge
            ZStack {
                // Background Images (behind the text)
                ForEach(0..<carouselItems.count, id: \.self) { index in
                    ZStack {
                        // Background Image
                        Image(carouselItems[index].backgroundImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 360)
                                .clipped()
                                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: currentPage)
                                .background(.ultraThinMaterial)
                        
                        Rectangle()
                            .foregroundColor(.black).opacity(0.8)
                    }
                    .scaleEffect(currentPage == index ? 1.0 : 1.0)
                    .opacity(currentPage == index ? 1.0 : 0.0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: currentPage)
                }
                
                // Fixed Text Content (stays in same position)
                VStack(spacing: 8) {
                    Text(carouselItems[currentPage].title)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text(carouselItems[currentPage].subtitle)
                        .font(.system(size: 20, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .padding(.top, 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentTransition(.numericText())
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: currentPage)
            }
            .frame(height: 340)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            // Swipe right - previous page
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentPage = max(0, currentPage - 1)
                            }
                        } else if value.translation.width < -threshold {
                            // Swipe left - next page
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentPage = min(carouselItems.count - 1, currentPage + 1)
                            }
                        }
                    }
            )
            
            // Custom Page Indicator
            HStack(spacing: 8) {
                ForEach(0..<carouselItems.count, id: \.self) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(currentPage == index ? .black : Color(red: 0.78, green: 0.78, blue: 0.76))
                        .scaleEffect(currentPage == index ? 1.4 : 1.0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: currentPage)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                currentPage = index
                            }
                        }
                }
            }
            .padding(.vertical, 20)
        }
    }
}



struct featuredBoard: View {
    let title: String
    let bigtitle: String
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack(alignment: .center, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text(bigtitle)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                 
                }
            .padding(.horizontal, 16)
            .padding(.top, 30)
            .frame(width: 393, alignment: .topLeading)
            
            ScrollView(.horizontal) {
                HStack {
                    FeaturedBoardCard(
                               title: "POV: You're in New York",
                               category: "Collages",
                               pinCount: 14,
                               timeAgo: "8mo",
                               mainImage: "cover-7",
                               smallImages: ["cover-6", "cover-5"],
                               colorHex: "#E3000E"
                           )
                    
                    FeaturedBoardCard(
                               title: "Soccer Aesthetic",
                               category: "Pinterest Man",
                               pinCount: 35,
                               timeAgo: "2w",
                               mainImage: "sc-1",
                               smallImages: ["sc-2", "sc-3"],
                               colorHex: "#E3000E"
                           )
                    
                    FeaturedBoardCard(
                               title: "Moon Images for Dreamers",
                               category: "Aesthetic",
                               pinCount: 51,
                               timeAgo: "2mo",
                               mainImage: "mn-1",
                               smallImages: ["mn-2", "mn-3"],
                               colorHex: "#E3000E"
                           )
                    
                    FeaturedBoardCard(
                               title: "Japan's blossom bucket list",
                               category: "Travel",
                               pinCount: 45,
                               timeAgo: "3mo",
                               mainImage: "jp-1",
                               smallImages: ["jp-2", "jp-3"],
                               colorHex: "#E3000E"
                           )
                    FeaturedBoardCard(
                               title: "Vibey Beach aesthetic",
                               category: "Travel",
                               pinCount: 94,
                               timeAgo: "8mo",
                               mainImage: "vb-1",
                               smallImages: ["vb-2", "vb-3"],
                               colorHex: "#E3000E"
                           )
                    FeaturedBoardCard(
                               title: "Minimalist black art",
                               category: "Aesthetic",
                               pinCount: 45,
                               timeAgo: "1mo",
                               mainImage: "cover-7",
                               smallImages: ["cover-6", "cover-5"],
                               colorHex: "#E3000E"
                           )
                }
                .padding(.leading,16)
           }
        }
    }
    
}

struct searchSection: View {
    let title: String
    let bigtitle: String
    let images: [String]
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack(alignment: .center, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text(bigtitle)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Image("chevron")
                        .frame(height: 42, alignment: .leading)
                }
            .padding(.horizontal, 16)
            .padding(.top, 30)
            .frame(width: 393, alignment: .topLeading)
            
            HStack(alignment: .center, spacing: 2) {
                Image(images[0])
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 93, height: 166)
               .clipped()
                
                Image(images[1])
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 93, height: 166)
               .clipped()
                
                Image(images[2])
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 93, height: 166)
               .clipped()
                
                Image(images[3])
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 93, height: 166)
               .clipped()
            }
            .padding(0)
            .frame(maxWidth: 373, alignment: .leading)
            .cornerRadius(16)
            }
        }
    
}

struct FeaturedBoardCard: View {
    let title: String
    let category: String
    let pinCount: Int
    let timeAgo: String
    let mainImage: String
    let smallImages: [String]
    let colorHex: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Card Preview Section with Images
            HStack(alignment: .top, spacing: 2) {
                // Main large image
                Image(mainImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 140, maxHeight: .infinity)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 2) {
                    // Top right small image
                    Image(smallImages[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .clipped()
                    
                    // Bottom right small image
                    Image(smallImages[1])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 70, maxHeight: .infinity)
                        .clipped()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .frame(width: 211, height: 142, alignment: .topLeading)
            .background(.white)
            .cornerRadius(16)
            
            // Text Content Section
            VStack(alignment: .leading, spacing: 6) {
                // Title
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                // Tags Row
                HStack(alignment: .center, spacing: 4) {
                    Text(category)
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                    
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(.red))
                    
                    Spacer()
                }
                
                // Stats Row
                HStack(alignment: .center, spacing: 4) {
                    Text("\(pinCount) Pins")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    
                    Circle()
                        .frame(width: 2, height: 2)
                        .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    
                    Text(timeAgo)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 4)
            .frame(maxWidth: 211, alignment: .leading)
        }
        .frame(maxWidth: 211, alignment: .leading)
    }
}
