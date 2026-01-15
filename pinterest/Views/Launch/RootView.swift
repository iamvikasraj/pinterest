//
//  RootView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct RootView: View {
    @State private var showSplash = true
    @State private var splashOpacity: Double = 1.0
    
    var body: some View {
        ZStack {
            // Main Content
            ContentView()
                .opacity(showSplash ? 0 : 1)
                .animation(.easeInOut(duration: 0.5), value: showSplash)
            
            // Splash Screen
            if showSplash {
                LaunchScreenView()
                    .opacity(splashOpacity)
                    .animation(.easeOut(duration: 0.5), value: splashOpacity)
            }
        }
        .onAppear {
            // Animation completes at 1.0 seconds, then remove splash
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    splashOpacity = 0
                }
                
                // Remove splash view after fade animation completes
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    RootView()
}

