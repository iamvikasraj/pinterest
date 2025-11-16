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
    
    init(viewModel: ContentViewModel) {
        self.contentViewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Segment Navigation
            segmentNavigation
            
            // Segment Content with swipe gesture
            segmentContent
                .id(selectedSegment)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 20)
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
                        }
                )
        }
    }
    
    private func switchToNextSegment() {
        guard let currentIndex = HomeSegment.allCases.firstIndex(of: selectedSegment) else { return }
        let nextIndex = currentIndex + 1
        if nextIndex < HomeSegment.allCases.count {
            transitionDirection = .forward
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                selectedSegment = HomeSegment.allCases[nextIndex]
            }
        }
    }
    
    private func switchToPreviousSegment() {
        guard let currentIndex = HomeSegment.allCases.firstIndex(of: selectedSegment) else { return }
        let previousIndex = currentIndex - 1
        if previousIndex >= 0 {
            transitionDirection = .backward
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
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
                    insertion: .move(edge: transitionDirection == .forward ? .trailing : .leading)
                        .combined(with: .opacity),
                    removal: .move(edge: transitionDirection == .forward ? .leading : .trailing)
                        .combined(with: .opacity)
                ))
        case .octavia:
            octaviaSegmentContent
                .transition(.asymmetric(
                    insertion: .move(edge: transitionDirection == .forward ? .trailing : .leading)
                        .combined(with: .opacity),
                    removal: .move(edge: transitionDirection == .forward ? .leading : .trailing)
                        .combined(with: .opacity)
                ))
        case .landscape:
            landscapeSegmentContent
                .transition(.asymmetric(
                    insertion: .move(edge: transitionDirection == .forward ? .trailing : .leading)
                        .combined(with: .opacity),
                    removal: .move(edge: transitionDirection == .forward ? .leading : .trailing)
                        .combined(with: .opacity)
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
            VStack(alignment: .leading, spacing: Spacing.lg) {
                // Octavia project specific content
                Text("Octavia 2.0 Project")
                    .font(Typography.Semantic.pageTitle)
                    .padding(.horizontal, Spacing.lg)
                    .padding(.top, Spacing.lg)
                
                HStack(alignment: .top, spacing: Spacing.sm) {
                    // Left column
                    VStack(spacing: Spacing.sm) {
                        ForEach(Array(viewModel.pins.prefix(6).enumerated()).filter { $0.offset % 2 == 0 }, id: \.element.id) { index, pin in
                            PinCard(
                                pin: pin,
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
                    VStack(spacing: Spacing.sm) {
                        ForEach(Array(viewModel.pins.prefix(6).enumerated()).filter { $0.offset % 2 == 1 }, id: \.element.id) { index, pin in
                            PinCard(
                                pin: pin,
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
        }
        .scrollIndicators(.hidden)
    }
    
    private var landscapeSegmentContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                // Landscape specific content
                Text("Landscape Thumbnails")
                    .font(Typography.Semantic.pageTitle)
                    .padding(.horizontal, Spacing.lg)
                    .padding(.top, Spacing.lg)
                
                HStack(alignment: .top, spacing: Spacing.sm) {
                    // Left column
                    VStack(spacing: Spacing.sm) {
                        ForEach(Array(viewModel.pins.suffix(9).enumerated()).filter { $0.offset % 2 == 0 }, id: \.element.id) { index, pin in
                            PinCard(
                                pin: pin,
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
                    VStack(spacing: Spacing.sm) {
                        ForEach(Array(viewModel.pins.suffix(9).enumerated()).filter { $0.offset % 2 == 1 }, id: \.element.id) { index, pin in
                            PinCard(
                                pin: pin,
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
        }
        .scrollIndicators(.hidden)
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
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                selectedSegment = segment
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, Spacing.lg)
        }
        .padding(.vertical, Spacing.md)
        .background(.white)
    }
}


#Preview {
    HomeView(viewModel: ContentViewModel())
}
