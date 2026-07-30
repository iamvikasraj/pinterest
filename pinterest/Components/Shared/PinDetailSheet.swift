//
//  PinDetailSheet.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Pin Detail Full Screen View
struct PinDetailSheet: View {
    @Binding var isPresented: Bool
    let pinId: String
    let imageName: String
    let sourceFrame: CGRect
    /// Retained for call-site compatibility. The expand animation no longer
    /// uses matchedGeometryEffect (see note below), so this is currently unused.
    let namespace: Namespace.ID

    // Drives the present/dismiss animation: 0 = collapsed at the card, 1 = full screen.
    @State private var progress: CGFloat = 0
    // Vertical drag offset for swipe-to-dismiss.
    @State private var dragHeight: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Solid background fades in with the transition.
                AppColors.backgroundPrimary
                    .ignoresSafeArea()
                    .opacity(backgroundOpacity)
                    .onTapGesture { dismiss() }

                // Foreground: full-width image + scrollable details.
                VStack(spacing: 0) {
                    pinImage(width: geometry.size.width)
                        .padding(.horizontal, Spacing.sm)
                        .padding(.top, geometry.safeAreaInsets.top + Spacing.sm)
                        .gesture(dismissDrag)

                    ScrollView(.vertical, showsIndicators: false) {
                        details
                            .padding(.horizontal, Spacing.lg)
                            .padding(.top, Spacing.xl)
                            .padding(.bottom, Spacing.xxl)
                            .opacity(progress)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .offset(y: dragHeight)

                closeButton(topInset: geometry.safeAreaInsets.top)
            }
            // Grow from the tapped card's position for a Pinterest-style zoom.
            .scaleEffect(0.88 + 0.12 * progress, anchor: zoomAnchor(in: geometry.size))
            .opacity(progress)
        }
        .onChange(of: isPresented) { _, presented in
            if presented { present() } else { collapse() }
        }
        .onAppear { if isPresented { present() } }
    }

    // MARK: - Subviews

    private func pinImage(width: CGFloat) -> some View {
        Group {
            if !imageName.isEmpty {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .background(AppColors.backgroundSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.large))
            }
        }
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Pin Details")
                .font(Typography.Semantic.pageTitle)
                .foregroundColor(AppColors.textPrimary)

            Text("Pin ID: \(pinId)")
                .font(Typography.Body.medium)
                .foregroundColor(AppColors.textSecondary)

            Text("This is a detailed view of the pin. You can add more information here like description, comments, related pins, etc.")
                .font(Typography.Body.medium)
                .foregroundColor(AppColors.textPrimary)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func closeButton(topInset: CGFloat) -> some View {
        HStack {
            Spacer()
            Button(action: dismiss) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 30))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Color.black.opacity(0.35))
            }
            .padding(.trailing, Spacing.lg)
        }
        .padding(.top, topInset + Spacing.sm)
        .opacity(progress)
    }

    // MARK: - Gestures

    private var dismissDrag: some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                // Only respond to a downward-ish vertical drag.
                if value.translation.height > 0,
                   abs(value.translation.height) > abs(value.translation.width) {
                    dragHeight = value.translation.height
                }
            }
            .onEnded { value in
                if value.translation.height > 120 {
                    dismiss()
                } else {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        dragHeight = 0
                    }
                }
            }
    }

    // MARK: - Animation helpers

    // Background dims out as the sheet is dragged away, so it feels tied to the gesture.
    private var backgroundOpacity: CGFloat {
        let dragFade = max(0, 1 - (dragHeight / 400))
        return progress * dragFade
    }

    private func zoomAnchor(in size: CGSize) -> UnitPoint {
        guard sourceFrame != .zero, size.width > 0, size.height > 0 else { return .center }
        return UnitPoint(
            x: min(max(sourceFrame.midX / size.width, 0), 1),
            y: min(max(sourceFrame.midY / size.height, 0), 1)
        )
    }

    private func present() {
        dragHeight = 0
        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
            progress = 1
        }
    }

    private func collapse() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
            progress = 0
            dragHeight = 0
        }
    }

    private func dismiss() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
            progress = 0
            dragHeight = 0
            isPresented = false
        }
    }
}
