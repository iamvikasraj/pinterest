//
//  OverlayComponents.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Bottom Overlay View
struct BottomOverlayView: View {
    @Binding var isPresented: Bool
    let imageContent: String
    
    var body: some View {
        GeometryReader { geometry in
            let sheetHeight: CGFloat = 400 // Approximate height of the sheet
            
            ZStack(alignment: .bottom) {
                // Bottom Sheet
                
                // Image - only show if imageContent is not empty
                if !imageContent.isEmpty {
                    Image(imageContent)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        .offset(y: -300)
                        .zIndex(1)
                        .scaleEffect(isPresented ? 1.0 : 0.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
                }
                
                
                VStack(spacing: 0) {
                    // Options section
                    VStack(spacing: 0) {
                        // Half outside the sheet
                        OverlayOptionRow(iconName: "square.and.arrow.up", title: "Share")
                        OverlayOptionRow(iconName: "bookmark", title: "Save")
                        OverlayOptionRow(iconName: "eye.slash", title: "Hide")
                        OverlayOptionRow(iconName: "square.and.arrow.down", title: "Download image")
                        OverlayOptionRow(iconName: "xmark.circle", title: "Stop seeing similar pins")
                        OverlayOptionRow(iconName: "exclamationmark.triangle", title: "Report")
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -5)
                .offset(y: isPresented ? 0 : sheetHeight)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}

// MARK: - Overlay Option Row
struct OverlayOptionRow: View {
    let iconName: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .font(Typography.Semantic.overlayOption)
                .foregroundColor(.black)
                .frame(width: 16, height: 16)
            
            Text(title)
                .font(Typography.Semantic.overlayOption)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.vertical, 12)
        .contentShape(Rectangle())
        .onTapGesture {
            // Handle option tap
            print("Tapped: \(title)")
        }
    }
}

// MARK: - Previews
#Preview("Bottom Overlay View - Shown") {
    struct PreviewWrapper: View {
        @State private var isPresented = true
        
        var body: some View {
            ZStack {
                Color.gray.opacity(0.3)
                    .ignoresSafeArea()
                
                BottomOverlayView(
                    isPresented: $isPresented,
                    imageContent: "one"
                )
            }
        }
    }
    
    return PreviewWrapper()
}

#Preview("Bottom Overlay View - Hidden") {
    struct PreviewWrapper: View {
        @State private var isPresented = false
        
        var body: some View {
            ZStack {
                Color.gray.opacity(0.3)
                    .ignoresSafeArea()
                
                BottomOverlayView(
                    isPresented: $isPresented,
                    imageContent: "two"
                )
            }
        }
    }
    
    return PreviewWrapper()
}

#Preview("Overlay Option Row") {
    VStack(spacing: 0) {
        OverlayOptionRow(iconName: "square.and.arrow.up", title: "Share")
        OverlayOptionRow(iconName: "bookmark", title: "Save")
        OverlayOptionRow(iconName: "eye.slash", title: "Hide")
    }
    .padding()
    .background(Color.white)
}
