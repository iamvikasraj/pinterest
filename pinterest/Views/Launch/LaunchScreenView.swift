//
//  LaunchScreenView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            // Background color matching Pinterest's brand
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Pinterest Logo with scale animation
                Image("pint")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        // Initial entrance animation - scales from 0.5 to 1.0
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                            scale = 1.0
                            opacity = 1.0
                        }
                        
                        // Subtle pulse animation - continuous gentle scale
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                scale = 1.1
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}

