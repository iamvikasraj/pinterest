//
//  PinDetailSheet.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Pin Detail Bottom Sheet
struct PinDetailSheet: View {
    @Binding var isPresented: Bool
    let pinId: String
    let imageName: String
    let sourceFrame: CGRect
    @State private var animationProgress: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let screenSize = geometry.size
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    // Pin Image with animated transition
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(CornerRadius.large)
                        .frame(maxWidth: .infinity)
                        .scaleEffect(
                            x: interpolate(
                                from: sourceFrame.width / screenWidth,
                                to: 1.0,
                                progress: animationProgress
                            ),
                            y: interpolate(
                                from: sourceFrame.height / screenHeight,
                                to: 1.0,
                                progress: animationProgress
                            ),
                            anchor: .topLeading
                        )
                        .offset(
                            x: interpolate(
                                from: sourceFrame.minX,
                                to: 0,
                                progress: animationProgress
                            ),
                            y: interpolate(
                                from: sourceFrame.minY,
                                to: 0,
                                progress: animationProgress
                            )
                        )
                        .opacity(animationProgress)
                    
                    // Pin Details
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
                    .padding(.horizontal, Spacing.lg)
                    .opacity(animationProgress)
                }
                .padding(.top, Spacing.lg)
                .padding(.bottom, Spacing.xxl)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                    animationProgress = 1.0
                }
            }
        }
    }
    
    private func interpolate(from: CGFloat, to: CGFloat, progress: CGFloat) -> CGFloat {
        from + (to - from) * progress
    }
}

