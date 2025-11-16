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
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 4)
                .padding(.top, Spacing.sm)
                .padding(.bottom, Spacing.lg)
            
            // Content
            VStack(spacing: Spacing.xl) {
                // Create Pin option
                CreateOptionRow(
                    icon: "photo",
                    title: "Create Pin",
                    subtitle: "Add a new Pin to your board"
                ) {
                    isPresented = false
                }
                
                // Create Board option
                CreateOptionRow(
                    icon: "square.grid.2x2",
                    title: "Create Board",
                    subtitle: "Organize your Pins"
                ) {
                    isPresented = false
                }
                
                // Create Idea Pin option
                CreateOptionRow(
                    icon: "video",
                    title: "Create Idea Pin",
                    subtitle: "Share a video or story"
                ) {
                    isPresented = false
                }
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.bottom, Spacing.xl)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 280)
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
                // Icon
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(AppColors.pinterestRed)
                    .frame(width: 48, height: 48)
                    .background(AppColors.backgroundSecondary)
                    .cornerRadius(CornerRadius.medium)
                
                // Text
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(title)
                        .font(Typography.Semantic.cardTitle)
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(subtitle)
                        .font(Typography.Caption.large)
                        .foregroundColor(AppColors.textSecondary)
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.textTertiary)
            }
            .padding(Spacing.lg)
            .background(Color.white)
            .cornerRadius(CornerRadius.large)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.large)
                    .stroke(AppColors.borderGray, lineWidth: 1)
            )
        }
    }
}

