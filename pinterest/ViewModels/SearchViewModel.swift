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
        isLoading = true
        DispatchQueue.main.async {
            self.carouselItems = self.dataService.fetchCarouselItems()
            self.featuredBoards = self.dataService.fetchFeaturedBoards()
            self.searchSections = self.dataService.fetchSearchSections()
            
            // Ensure currentCarouselPage is within bounds
            if !self.carouselItems.isEmpty && self.currentCarouselPage >= self.carouselItems.count {
                self.currentCarouselPage = 0
            }
            
            self.isLoading = false
        }
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

