//
//  ContentViewModel.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var selectedTab: Tab = .home
    @Published var showOverlay = false
    @Published var selectedImageContent = ""
    
    // Navigation stack for in-page navigation
    @Published var navigationPath = NavigationPath()
    
    func selectTab(_ tab: Tab) {
        selectedTab = tab
        // Clear navigation path when switching tabs
        navigationPath.removeLast(navigationPath.count)
    }
    
    func showImageOverlay(imageContent: String) {
        selectedImageContent = imageContent
        showOverlay = true
    }
    
    func hideOverlay() {
        showOverlay = false
    }
    
    // Navigation methods
    func navigate(to route: Route) {
        navigationPath.append(route)
    }
    
    func navigateBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}

