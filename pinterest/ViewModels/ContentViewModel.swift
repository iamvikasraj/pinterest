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
    @Published var showCreateBottomSheet = false
    @Published var showPinDetailSheet = false
    @Published var selectedPinId: String = ""
    @Published var selectedPinImageName: String = ""
    @Published var sourceFrame: CGRect = .zero
    
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
    
    func showCreateSheet() {
        showCreateBottomSheet = true
    }
    
    func hideCreateSheet() {
        showCreateBottomSheet = false
    }
    
    func showPinDetail(pinId: String, imageName: String, sourceFrame: CGRect = .zero) {
        selectedPinId = pinId
        selectedPinImageName = imageName
        self.sourceFrame = sourceFrame
        showPinDetailSheet = true
    }
    
    func hidePinDetailSheet() {
        showPinDetailSheet = false
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

