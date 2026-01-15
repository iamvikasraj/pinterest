//
//  CreateBottomSheet.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Create Bottom Sheet
struct CreateBottomSheet: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let sheetHeight: CGFloat = 180
            
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // Handle bar
                    Text("Start creating now")
                        .font(Typography.Caption.xlarge)
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                
                    
                    // Content
                    HStack(spacing: 0) {
                        
                        // Create Pin option
                        CreateOptionRow(
                            icon: "pin",
                            title: "Pin",
                            subtitle: "Add a new Pin to your board"
                        ) {
                            isPresented = false
                        }
                        
                        // Create Board option
                        CreateOptionRow(
                            icon: "Collage",
                            title: "Collage",
                            subtitle: "Organize your Pins"
                        ) {
                            isPresented = false
                        }
                        
                        // Create Idea Pin option
                        CreateOptionRow(
                            icon: "Board",
                            title: "Board",
                            subtitle: "Share a video or story"
                        ) {
                            isPresented = false
                        }
                    }
                    .padding(.horizontal, Spacing.lg)
                    .padding(.bottom, Spacing.xl)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -5)
                .offset(y: isPresented ? 0 : sheetHeight)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}


// MARK: - Create Option Row
struct CreateOptionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.lg) {
                // Text
                VStack(alignment: .center, spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: CornerRadius.xlarge)
                            .fill(AppColors.backgroundSecondary)
                            .frame(width: 72, height: 72)
                        
                        Image(icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                    
                    Text(title)
                        .font(Typography.Caption.small)
                        .foregroundColor(AppColors.textPrimary)
                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(CornerRadius.large)
        }
    }
}

// MARK: - Previews
#Preview("Create Bottom Sheet") {
    struct PreviewWrapper: View {
        @State private var isPresented = true
        
        var body: some View {
            ZStack {
                Color.gray.opacity(0.3)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    CreateBottomSheet(isPresented: $isPresented)
                }
            }
        }
    }
    
    return PreviewWrapper()
}

#Preview("Create Option Row") {
    CreateOptionRow(
        icon: "pin",
        title: "Create Pin",
        subtitle: "Add a new Pin to your board"
    ) {
        print("Create Pin tapped")
    }
    .padding()
}
