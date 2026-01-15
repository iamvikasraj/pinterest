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
    let namespace: Namespace.ID
    @State private var animationProgress: CGFloat = 0
    @State private var dragHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Color.white
                    .ignoresSafeArea()
                    .opacity(isPresented ? 1 : 0)
                    .onTapGesture {
                        if isPresented {
                            dismissView()
                        }
                    }
                
                VStack(spacing: 0) {
                    // Pin Image with matched geometry effect - full width with 10px padding
                    // Place image outside ScrollView for better matched geometry effect
                    if !imageName.isEmpty {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width - 20)
                            .cornerRadius(16)
                            .matchedGeometryEffect(id: pinId, in: namespace, isSource: false)
                            .padding(.horizontal, 10)
                            .padding(.top, Spacing.lg)
                            .opacity(isPresented ? 1 : 0)
                            .gesture(
                                DragGesture(minimumDistance: 10)
                                    .onChanged { value in
                                        // Only allow vertical drag for dismiss, ignore horizontal
                                        if abs(value.translation.height) > abs(value.translation.width) {
                                            dragHeight = value.translation.height
                                        }
                                    }
                                    .onEnded { value in
                                        // Only dismiss on vertical drag
                                        if abs(value.translation.height) > 100 {
                                            dismissView()
                                        } else {
                                            withAnimation {
                                                dragHeight = 0
                                            }
                                        }
                                    }
                            )
                    }
                    
                    // Scrollable content below image
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(alignment: .leading, spacing: Spacing.lg) {
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
                        .padding(.bottom, Spacing.xxl)
                    }
                    .opacity(isPresented ? 1 : 0)
                }
                .offset(y: dragHeight)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
                // Close button
                VStack {
                    HStack {
                        Spacer()
                        Button(action: dismissView) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(.top, 50)
                        .padding(.trailing, 20)
                    }
                    Spacer()
                }
                .opacity(isPresented ? 1 : 0)
            }
        }
        .onAppear {
            // Animate details fade-in, but let matched geometry handle image transition
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75).delay(0.2)) {
                animationProgress = 1.0
            }
        }
    }
    
    private func dismissView() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            animationProgress = 0
            isPresented = false
        }
    }
}

