//
//  SearchViewModel.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var scrollOffset: CGFloat = 0
    @Published var carouselItems: [CarouselItem] = []
    @Published var currentCarouselPage = 0
    @Published var featuredBoards: [FeaturedBoard] = []
    @Published var searchSections: [SearchSection] = []
    @Published var isLoading = false
    
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
        loadData()
    }
    
    func loadData() {
        // Load synchronously so the first rendered frame is already populated.
        // Dispatching to a later runloop tick left the carousel empty on frame one,
        // causing a visible layout pop each time the Search tab appeared.
        carouselItems = dataService.fetchCarouselItems()
        featuredBoards = dataService.fetchFeaturedBoards()
        searchSections = dataService.fetchSearchSections()

        // Ensure currentCarouselPage is within bounds
        if !carouselItems.isEmpty && currentCarouselPage >= carouselItems.count {
            currentCarouselPage = 0
        }

        isLoading = false
    }
    
    func updateScrollOffset(_ offset: CGFloat) {
        scrollOffset = offset
    }
    
    func navigateCarousel(direction: CarouselDirection) {
        switch direction {
        case .next:
            if currentCarouselPage < carouselItems.count - 1 {
                currentCarouselPage += 1
            }
        case .previous:
            if currentCarouselPage > 0 {
                currentCarouselPage -= 1
            }
        }
    }
    
    func setCarouselPage(_ page: Int) {
        guard page >= 0 && page < carouselItems.count else { return }
        currentCarouselPage = page
    }
}

enum CarouselDirection {
    case next
    case previous
}

