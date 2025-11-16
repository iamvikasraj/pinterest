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
            ZStack(alignment: .bottom) {
                // Bottom Sheet
                VStack(spacing: 0) {
                    // Handle bar
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 6)
                        .padding(.top, 12)
                    
                    // Image positioned at the top with half outside effect
                    VStack {
                        Image(imageContent)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipped()
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                            .offset(y: -40) // Half outside the sheet
                    }
                    .padding(.top, 20)
                    
                    // Options section
                    VStack(spacing: 0) {
                        OverlayOptionRow(iconName: "square.and.arrow.up", title: "Share")
                        OverlayOptionRow(iconName: "bookmark", title: "Save")
                        OverlayOptionRow(iconName: "eye.slash", title: "Hide")
                        OverlayOptionRow(iconName: "square.and.arrow.down", title: "Download image")
                        OverlayOptionRow(iconName: "xmark.circle", title: "Stop seeing similar pins")
                        OverlayOptionRow(iconName: "exclamationmark.triangle", title: "Report")
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -5)
                .offset(y: isPresented ? 0 : geometry.size.height + 100)
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0), value: isPresented)
            }
            .ignoresSafeArea(.all)
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

