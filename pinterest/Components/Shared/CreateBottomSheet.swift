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
        VStack(spacing: 0) {
            // Handle bar
            Text("Start creating now")
                .font(Typography.Caption.xs)
                .foregroundColor(AppColors.textPrimary)
                .padding(.top, 16)
                .padding(.bottom, 16)
        
            
            // Content
            HStack(spacing: Spacing.xl) {
                
                // Create Pin option
                CreateOptionRow(
                    icon: "photo",
                    title: "Pin",
                    subtitle: "Add a new Pin to your board"
                ) {
                    isPresented = false
                }
                
                // Create Board option
                CreateOptionRow(
                    icon: "square.grid.2x2",
                    title: "Collage",
                    subtitle: "Organize your Pins"
                ) {
                    isPresented = false
                }
                
                // Create Idea Pin option
                CreateOptionRow(
                    icon: "video",
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
                VStack(alignment: .center, spacing: Spacing.xs) {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .frame(width: 48, height: 48)
                        .background(AppColors.backgroundSecondary)
                        .cornerRadius(CornerRadius.medium)
                    
                    Text(title)
                        .font(Typography.Caption.xs)
                        .foregroundColor(AppColors.textPrimary)
                }
            }
            .padding(Spacing.lg)
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
                Color.gray.opacity(0.1)
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
        icon: "photo",
        title: "Create Pin",
        subtitle: "Add a new Pin to your board"
    ) {
        print("Create Pin tapped")
    }
    .padding()
}
