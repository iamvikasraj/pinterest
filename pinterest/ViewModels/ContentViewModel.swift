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
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            showOverlay = true
        }
    }
    
    func hideOverlay() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            showOverlay = false
        }
        // Clear the image content after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if !self.showOverlay {
                self.selectedImageContent = ""
            }
        }
    }
    
    func showCreateSheet() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            showCreateBottomSheet = true
        }
    }
    
    func hideCreateSheet() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            showCreateBottomSheet = false
        }
    }
    
    func showPinDetail(pinId: String, imageName: String, sourceFrame: CGRect = .zero) {
        // Set the pin details first
        selectedPinId = pinId
        selectedPinImageName = imageName
        self.sourceFrame = sourceFrame
        
        // Show with animation for matched geometry effect
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            showPinDetailSheet = true
        }
    }
    
    func hidePinDetailSheet() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            showPinDetailSheet = false
        }
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

