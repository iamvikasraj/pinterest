//
//  FeaturedBoardCard.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Featured Board Card
struct FeaturedBoardCard: View {
    let board: FeaturedBoard
    var onBoardTapped: ((String) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Card Preview Section with Images
            HStack(alignment: .top, spacing: 2) {
                // Main large image
                if !board.mainImage.isEmpty {
                    Image(board.mainImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 140, maxHeight: .infinity)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(minWidth: 140, maxHeight: .infinity)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    // Top right small image
                    if board.smallImages.count > 0 && !board.smallImages[0].isEmpty {
                        Image(board.smallImages[0])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 70, maxHeight: 70)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(maxWidth: 70, maxHeight: 70)
                    }
                    
                    // Bottom right small image
                    if board.smallImages.count > 1 && !board.smallImages[1].isEmpty {
                        Image(board.smallImages[1])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 70, maxHeight: .infinity)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(maxWidth: 70, maxHeight: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .frame(width: 211, height: 142, alignment: .topLeading)
            .background(.white)
            .cornerRadius(16)
            
            // Text Content Section
            VStack(alignment: .leading, spacing: 6) {
                // Title
                Text(board.title)
                    .font(Typography.Semantic.cardTitle)
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                // Tags Row
                HStack(alignment: .center, spacing: 4) {
                    Text(board.category)
                        .font(Typography.Caption.large)
                        .foregroundColor(.black)
                    
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(.red))
                    
                    Spacer()
                }
                
                // Stats Row
                HStack(alignment: .center, spacing: 4) {
                    Text("\(board.pinCount) Pins")
                        .font(Typography.Caption.large)
                        .foregroundColor(AppColors.textSecondary)
                    
                    Circle()
                        .frame(width: 2, height: 2)
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(board.timeAgo)
                        .font(Typography.Caption.large)
                        .foregroundColor(AppColors.textSecondary)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 4)
            .frame(maxWidth: 211, alignment: .leading)
        }
        .frame(maxWidth: 211, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            onBoardTapped?(board.id.uuidString)
        }
    }
}
