//
//  HomeView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    let contentViewModel: ContentViewModel
    let pinImageNamespace: Namespace.ID
    @Namespace private var underlineNamespace
    @State private var selectedSegment: HomeSegment = .all
    @State private var transitionDirection: TransitionDirection = .none
    
    enum HomeSegment: String, CaseIterable {
        case all = "All"
        case octavia = "Octavia 2.0 project"
        case landscape = "Landscape thumbnai"
    }
    
    enum TransitionDirection {
        case forward, backward, none
    }
    
    init(viewModel: ContentViewModel, pinImageNamespace: Namespace.ID) {
        self.contentViewModel = viewModel
        self.pinImageNamespace = pinImageNamespace
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Segment Navigation
            segmentNavigation
            
            // Segment Content with swipe gesture (disabled when pin detail is shown)
            segmentContent
                .id(selectedSegment)
                .simultaneousGesture(
                    !contentViewModel.showPinDetailSheet ? DragGesture(minimumDistance: 20)
                        .onEnded { value in
                            let horizontalAmount = value.translation.width
                            let verticalAmount = abs(value.translation.height)
                            let swipeThreshold: CGFloat = 50
                            
                            // Only trigger if horizontal swipe is more dominant than vertical
                            if abs(horizontalAmount) > verticalAmount && abs(horizontalAmount) > swipeThreshold {
                                if horizontalAmount > 0 {
                                    // Swipe right - go to previous segment
                                    switchToPreviousSegment()
                                } else {
                                    // Swipe left - go to next segment
                                    switchToNextSegment()
                                }
                            }
                        } : nil
                )
        }
    }
    
    private func switchToNextSegment() {
        guard let currentIndex = HomeSegment.allCases.firstIndex(of: selectedSegment) else { return }
        let nextIndex = currentIndex + 1
        if nextIndex < HomeSegment.allCases.count {
            transitionDirection = .forward
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedSegment = HomeSegment.allCases[nextIndex]
            }
        }
    }
    
    private func switchToPreviousSegment() {
        guard let currentIndex = HomeSegment.allCases.firstIndex(of: selectedSegment) else { return }
        let previousIndex = currentIndex - 1
        if previousIndex >= 0 {
            transitionDirection = .backward
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedSegment = HomeSegment.allCases[previousIndex]
            }
        }
    }
    
    @ViewBuilder
    private var segmentContent: some View {
        switch selectedSegment {
        case .all:
            allSegmentContent
                .transition(.asymmetric(
                    insertion: .move(edge: transitionDirection == .forward ? .trailing : .leading),
                    removal: .move(edge: transitionDirection == .forward ? .leading : .trailing)
                ))
        case .octavia:
            octaviaSegmentContent
                .transition(.asymmetric(
                    insertion: .move(edge: transitionDirection == .forward ? .trailing : .leading),
                    removal: .move(edge: transitionDirection == .forward ? .leading : .trailing)
                ))
        case .landscape:
            landscapeSegmentContent
                .transition(.asymmetric(
                    insertion: .move(edge: transitionDirection == .forward ? .trailing : .leading),
                    removal: .move(edge: transitionDirection == .forward ? .leading : .trailing)
                ))
        }
    }
    
    private var allSegmentContent: some View {
        ScrollView {
            HStack(alignment: .top, spacing: Spacing.xs) {
                // Left column
                VStack(spacing: Spacing.xs) {
                    ForEach(Array(viewModel.pins.enumerated()).filter { $0.offset % 2 == 0 }, id: \.element.id) { index, pin in
                        PinCard(
                            pin: pin,
                            namespace: pinImageNamespace,
                            selectedPinId: contentViewModel.selectedPinId,
                            onMoreTapped: {
                                contentViewModel.showImageOverlay(imageContent: pin.imageName)
                            },
                            onPinTapped: { pinId, imageName, frame in
                                contentViewModel.showPinDetail(pinId: pinId, imageName: imageName, sourceFrame: frame)
                            }
                        )
                    }
                }
                
                // Right column
                VStack(spacing: Spacing.xs) {
                    ForEach(Array(viewModel.pins.enumerated()).filter { $0.offset % 2 == 1 }, id: \.element.id) { index, pin in
                        PinCard(
                            pin: pin,
                            namespace: pinImageNamespace,
                            selectedPinId: contentViewModel.selectedPinId,
                            onMoreTapped: {
                                contentViewModel.showImageOverlay(imageContent: pin.imageName)
                            },
                            onPinTapped: { pinId, imageName, frame in
                                contentViewModel.showPinDetail(pinId: pinId, imageName: imageName, sourceFrame: frame)
                            }
                        )
                    }
                }
            }
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.sm)
        }
        .scrollIndicators(.hidden)
    }
    
    private var octaviaSegmentContent: some View {
        ScrollView {
            HStack(alignment: .top, spacing: Spacing.xs) {
                // Left column
                VStack(spacing: Spacing.xs) {
                    ForEach(dummyOctaviaPins.filter { $0.offset % 2 == 0 }, id: \.element.id) { index, pin in
                        PinCard(
                            pin: pin,
                            namespace: pinImageNamespace,
                            selectedPinId: contentViewModel.selectedPinId,
                            onMoreTapped: {
                                contentViewModel.showImageOverlay(imageContent: pin.imageName)
                            },
                            onPinTapped: { pinId, imageName, frame in
                                contentViewModel.showPinDetail(pinId: pinId, imageName: imageName, sourceFrame: frame)
                            }
                        )
                    }
                }
                
                // Right column
                VStack(spacing: Spacing.xs) {
                    ForEach(dummyOctaviaPins.filter { $0.offset % 2 == 1 }, id: \.element.id) { index, pin in
                        PinCard(
                            pin: pin,
                            namespace: pinImageNamespace,
                            selectedPinId: contentViewModel.selectedPinId,
                            onMoreTapped: {
                                contentViewModel.showImageOverlay(imageContent: pin.imageName)
                            },
                            onPinTapped: { pinId, imageName, frame in
                                contentViewModel.showPinDetail(pinId: pinId, imageName: imageName, sourceFrame: frame)
                            }
                        )
                    }
                }
            }
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.sm)
        }
        .scrollIndicators(.hidden)
    }
    
    private var dummyOctaviaPins: [(offset: Int, element: Pin)] {
        // Fixed heights (halved): 177pt (small), 268pt (medium), 316pt (large)
        // Pattern: large → medium → small → large → medium → small (repeating)
        let heights: [CGFloat] = [
            316, // Large
            268, // Medium
            177, // Small
            316, // Large
            268, // Medium
            177, // Small
            316, // Large
            268, // Medium
            177, // Small
            316, // Large
            268, // Medium
            177  // Small
        ]
        
        return (0..<12).enumerated().map { index, _ in
            let height = index < heights.count ? heights[index] : 268
            return (offset: index, element: Pin(imageName: "", title: "Octavia Pin \(index + 1)", fixedHeight: height))
        }
    }
    
    private var landscapeSegmentContent: some View {
        ScrollView {
            HStack(alignment: .top, spacing: Spacing.xs) {
                // Left column
                VStack(spacing: Spacing.xs) {
                    ForEach(dummyLandscapePins.filter { $0.offset % 2 == 0 }, id: \.element.id) { index, pin in
                        PinCard(
                            pin: pin,
                            namespace: pinImageNamespace,
                            selectedPinId: contentViewModel.selectedPinId,
                            onMoreTapped: {
                                contentViewModel.showImageOverlay(imageContent: pin.imageName)
                            },
                            onPinTapped: { pinId, imageName, frame in
                                contentViewModel.showPinDetail(pinId: pinId, imageName: imageName, sourceFrame: frame)
                            }
                        )
                    }
                }
                
                // Right column
                VStack(spacing: Spacing.xs) {
                    ForEach(dummyLandscapePins.filter { $0.offset % 2 == 1 }, id: \.element.id) { index, pin in
                        PinCard(
                            pin: pin,
                            namespace: pinImageNamespace,
                            selectedPinId: contentViewModel.selectedPinId,
                            onMoreTapped: {
                                contentViewModel.showImageOverlay(imageContent: pin.imageName)
                            },
                            onPinTapped: { pinId, imageName, frame in
                                contentViewModel.showPinDetail(pinId: pinId, imageName: imageName, sourceFrame: frame)
                            }
                        )
                    }
                }
            }
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.sm)
        }
        .scrollIndicators(.hidden)
    }
    
    private var dummyLandscapePins: [(offset: Int, element: Pin)] {
        // Fixed heights (halved): 177pt (small), 268pt (medium), 316pt (large)
        // Pattern: large → medium → small → large → medium → small (repeating)
        let heights: [CGFloat] = [
            316, // Large
            268, // Medium
            177, // Small
            316, // Large
            268, // Medium
            177, // Small
            316, // Large
            268, // Medium
            177, // Small
            316, // Large
            268, // Medium
            177  // Small
        ]
        
        return (0..<12).enumerated().map { index, _ in
            let height = index < heights.count ? heights[index] : 268
            return (offset: index, element: Pin(imageName: "", title: "Landscape Pin \(index + 1)", fixedHeight: height))
        }
    }
    
    private var segmentNavigation: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xl) {
                ForEach(HomeSegment.allCases, id: \.self) { segment in
                    NavigationTab(
                        title: segment.rawValue,
                        isSelected: selectedSegment == segment,
                        onTap: {
                            // Determine direction based on current and new segment
                            if let currentIndex = HomeSegment.allCases.firstIndex(of: selectedSegment),
                               let newIndex = HomeSegment.allCases.firstIndex(of: segment) {
                                transitionDirection = newIndex > currentIndex ? .forward : .backward
                            }
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedSegment = segment
                            }
                        },
                        namespace: underlineNamespace,
                        tabId: segment.rawValue
                    )
                }
            }
            .padding(.horizontal, Spacing.lg)
        }
        .padding(.vertical, Spacing.md)
        .background(.white)
    }
}


#Preview("Home View") {
    struct PreviewWrapper: View {
        @Namespace private var namespace
        var body: some View {
            HomeView(viewModel: ContentViewModel(), pinImageNamespace: namespace)
        }
    }
    return PreviewWrapper()
}

#Preview("Home View - Dark Mode") {
    struct PreviewWrapper: View {
        @Namespace private var namespace
        var body: some View {
            HomeView(viewModel: ContentViewModel(), pinImageNamespace: namespace)
                .preferredColorScheme(.dark)
        }
    }
    return PreviewWrapper()
}
