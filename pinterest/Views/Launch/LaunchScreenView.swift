//
//  LaunchScreenView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct LaunchScreenView: View {
    // Pinterest logo states
    @State private var logoScale: CGFloat = 1.0
    @State private var logoOpacity: Double = 1.0
    
    // 5 icons states
    @State private var icon1Scale: CGFloat = 0
    @State private var icon1Opacity: Double = 0
    @State private var icon2Scale: CGFloat = 0
    @State private var icon2Opacity: Double = 0
    @State private var icon3Scale: CGFloat = 0
    @State private var icon3Opacity: Double = 0
    @State private var icon4Scale: CGFloat = 0
    @State private var icon4Opacity: Double = 0
    @State private var icon5Scale: CGFloat = 0
    @State private var icon5Opacity: Double = 0
    
    // Emojis for now (will be replaced with icons later)
    private let emojis = ["🏠", "🔍", "➕", "💬", "👤"]
    
    var body: some View {
        ZStack {
            // Background color matching Pinterest's brand
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: Spacing.xl) {
                // Pinterest Logo
                Image("pint")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                
                // 5 Icons arranged horizontally
                HStack(spacing: Spacing.lg) {
                    Text(emojis[0])
                        .font(.system(size: 16))
                        .frame(width: 16, height: 16)
                        .scaleEffect(icon1Scale)
                        .opacity(icon1Opacity)
                    
                    Text(emojis[1])
                        .font(.system(size: 16))
                        .frame(width: 16, height: 16)
                        .scaleEffect(icon2Scale)
                        .opacity(icon2Opacity)
                    
                    Text(emojis[2])
                        .font(.system(size: 16))
                        .frame(width: 16, height: 16)
                        .scaleEffect(icon3Scale)
                        .opacity(icon3Opacity)
                    
                    Text(emojis[3])
                        .font(.system(size: 16))
                        .frame(width: 16, height: 16)
                        .scaleEffect(icon4Scale)
                        .opacity(icon4Opacity)
                    
                    Text(emojis[4])
                        .font(.system(size: 16))
                        .frame(width: 16, height: 16)
                        .scaleEffect(icon5Scale)
                        .opacity(icon5Opacity)
                }
            }
            .onAppear {
                resetAnimation()
                startAnimation()
            }
        }
    }
    
    private func resetAnimation() {
        // Reset all states to initial values
        logoScale = 1.0
        logoOpacity = 1.0
        icon1Scale = 0
        icon1Opacity = 0
        icon2Scale = 0
        icon2Opacity = 0
        icon3Scale = 0
        icon3Opacity = 0
        icon4Scale = 0
        icon4Opacity = 0
        icon5Scale = 0
        icon5Opacity = 0
    }
    
    private func startAnimation() {
        // 0.00 - 0.12: Logo stays static (no change needed, already at scale 1.0)
        
        // 0.12 - 0.18: Logo scales down
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            withAnimation(.easeInOut(duration: 0.06)) {
                logoScale = 0.7
            }
        }
        
        // 0.18 - 0.50: Logo scales back to original + 5 icons appear and scale up
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            // Logo scales back to original and icons appear simultaneously
            withAnimation(.easeInOut(duration: 0.32)) {
                logoScale = 1.0
                icon1Scale = 1.0
                icon1Opacity = 1.0
                icon2Scale = 1.0
                icon2Opacity = 1.0
                icon3Scale = 1.0
                icon3Opacity = 1.0
                icon4Scale = 1.0
                icon4Opacity = 1.0
                icon5Scale = 1.0
                icon5Opacity = 1.0
            }
        }
        
        // 0.50 - 1.0: All fade out
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
            withAnimation(.easeOut(duration: 0.5)) {
                logoOpacity = 0.0
                icon1Opacity = 0.0
                icon2Opacity = 0.0
                icon3Opacity = 0.0
                icon4Opacity = 0.0
                icon5Opacity = 0.0
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}

#Preview("With Restart Button") {
    struct PreviewWrapper: View {
        @State private var restartKey = 0
        
        var body: some View {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
                
                VStack {
                    LaunchScreenView()
                        .id(restartKey)
                    
                    Button("Restart Animation") {
                        restartKey += 1
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top, 50)
                }
            }
        }
    }
    return PreviewWrapper()
}
