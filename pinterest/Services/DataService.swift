//
//  DataService.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation
import Combine

protocol DataServiceProtocol {
    func fetchPins() -> [Pin]
    func fetchMessages() -> [Message]
    func fetchUpdates() -> [Update]
    func fetchCarouselItems() -> [CarouselItem]
    func fetchFeaturedBoards() -> [FeaturedBoard]
    func fetchSearchSections() -> [SearchSection]
}

class MockDataService: DataServiceProtocol, ObservableObject {
    @Published var isLoading = false
    
    func fetchPins() -> [Pin] {
        return [
            Pin(imageName: "one"),
            Pin(imageName: "two"),
            Pin(imageName: "three"),
            Pin(imageName: "fourth"),
            Pin(imageName: "fifth"),
            Pin(imageName: "one"),
            Pin(imageName: "two"),
            Pin(imageName: "three"),
            Pin(imageName: "fourth"),
            Pin(imageName: "fifth")
        ]
    }
    
    func fetchMessages() -> [Message] {
        return [
            Message(senderName: "Pinterest", messagePreview: "Sent a Pin!", timestamp: "3y"),
            Message(senderName: "Design Team", messagePreview: "New board shared", timestamp: "1d")
        ]
    }
    
    func fetchUpdates() -> [Update] {
        return [
            Update(message: "New pins added to your Home feed", imageName: "one"),
            Update(message: "Weekly trends: Minimalist design is trending", imageName: "two"),
            Update(message: "Your board 'Kitchen Ideas' got 50 new saves", imageName: "three"),
            Update(message: "Recommended: Summer fashion pins", imageName: "fourth"),
            Update(message: "Pin performance: Your latest pin reached 1K views", imageName: "one")
        ]
    }
    
    func fetchCarouselItems() -> [CarouselItem] {
        return [
            CarouselItem(title: "A piece of cake", subtitle: "Anyone can bake recipes", backgroundImage: "cover-1"),
            CarouselItem(title: "Uplifting quotes", subtitle: "Words to hear today", backgroundImage: "cover-2"),
            CarouselItem(title: "Stand out", subtitle: "Backpack styling for men", backgroundImage: "cover-3"),
            CarouselItem(title: "A touch of cute", subtitle: "Pink room decor of your dreams", backgroundImage: "cover-4"),
            CarouselItem(title: "Casual chic", subtitle: "Kolhapuris for men & women", backgroundImage: "cover-5")
        ]
    }
    
    func fetchFeaturedBoards() -> [FeaturedBoard] {
        return [
            FeaturedBoard(title: "POV: You're in New York", category: "Collages", pinCount: 14, timeAgo: "8mo", mainImage: "cover-7", smallImages: ["cover-6", "cover-5"], colorHex: "#E3000E"),
            FeaturedBoard(title: "Soccer Aesthetic", category: "Pinterest Man", pinCount: 35, timeAgo: "2w", mainImage: "sc-1", smallImages: ["sc-2", "sc-3"], colorHex: "#E3000E"),
            FeaturedBoard(title: "Moon Images for Dreamers", category: "Aesthetic", pinCount: 51, timeAgo: "2mo", mainImage: "mn-1", smallImages: ["mn-2", "mn-3"], colorHex: "#E3000E"),
            FeaturedBoard(title: "Japan's blossom bucket list", category: "Travel", pinCount: 45, timeAgo: "3mo", mainImage: "jp-1", smallImages: ["jp-2", "jp-3"], colorHex: "#E3000E"),
            FeaturedBoard(title: "Vibey Beach aesthetic", category: "Travel", pinCount: 94, timeAgo: "8mo", mainImage: "vb-1", smallImages: ["vb-2", "vb-3"], colorHex: "#E3000E"),
            FeaturedBoard(title: "Minimalist black art", category: "Aesthetic", pinCount: 45, timeAgo: "1mo", mainImage: "cover-7", smallImages: ["cover-6", "cover-5"], colorHex: "#E3000E")
        ]
    }
    
    func fetchSearchSections() -> [SearchSection] {
        return [
            SearchSection(title: "Popular on Pinterest", bigTitle: "Hunter 350", images: ["search-1", "search-2", "search-3", "search-4"]),
            SearchSection(title: "Ideas for you", bigTitle: "Furniture graphics", images: ["fg-1", "fg-2", "fg-3", "fg-4"]),
            SearchSection(title: "Ideas for you", bigTitle: "Mobile Design", images: ["md-1", "md-2", "md-3", "md-4"]),
            SearchSection(title: "Ideas for you", bigTitle: "Gents shoes", images: ["gs-1", "gs-2", "gs-3", "gs-4"]),
            SearchSection(title: "Popular on Pinterest", bigTitle: "Cars", images: ["cars-1", "cars-2", "cars-3", "cars-4"])
        ]
    }
    
    func refreshData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isLoading = false
        }
    }
}

