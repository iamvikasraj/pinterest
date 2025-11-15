//
//  CardComponents.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Pin Card
struct PinCard: View {
    let pin: Pin
    let onMoreTapped: () -> Void
    var onPinTapped: ((String) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            VStack(alignment: .leading, spacing: 10) {
                Image(pin.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(maxWidth: 190, alignment: .topLeading)
            .background(Color(red: 0.73, green: 0.73, blue: 0.73))
            .cornerRadius(16)
            .clipped()
            .onTapGesture {
                onPinTapped?(pin.id.uuidString)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Image("more")
                    .onTapGesture {
                        onMoreTapped()
                    }
            }
        }
        .padding(0)
        .frame(width: 191, alignment: .bottomTrailing)
    }
}

// MARK: - Message Card
struct MessageCard: View {
    let message: Message
    var onMessageTapped: ((String) -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Text(String(message.senderName.prefix(1)))
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(width: 46, height: 46)
            .background(Color(red: 0.91, green: 0.9, blue: 0.88))
            .cornerRadius(11)
            
            VStack(spacing: 4) {
                Text(message.senderName)
                    .font(Font.custom("Inter", size: 15).weight(.medium))
                    .kerning(0.15)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text(message.messagePreview)
                    .font(Font.custom("Inter", size: 15))
                    .kerning(0.15)
                    .foregroundColor(Color(red: 0.59, green: 0.57, blue: 0.57))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            
            Spacer()
            
            Text(message.timestamp)
                .font(Font.custom("Inter", size: 12))
                .kerning(0.12)
                .foregroundColor(Color(red: 0.59, green: 0.57, blue: 0.57))
        }
        .padding(.top, 16)
        .contentShape(Rectangle())
        .onTapGesture {
            onMessageTapped?(message.id.uuidString)
        }
    }
}

// MARK: - Update Card
struct UpdateCard: View {
    let update: Update
    
    var body: some View {
        HStack {
            ZStack {
                Image(update.imageName)
                    .foregroundColor(.gray)
                    .font(.title2)
            }
            .frame(width: 46, height: 64)
            .background(Color(red: 0.91, green: 0.9, blue: 0.88))
            .cornerRadius(8)
            
            Text(update.message)
                .font(Font.custom("Inter", size: 15).weight(.medium))
                .kerning(0.15)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            Button(action: {
                print("More options for: \(update.message)")
            }) {
                Image(systemName: "ellipsis")
                    .frame(width: 14, height: 24)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .onTapGesture {
            print("Update tapped: \(update.message)")
        }
    }
}

// MARK: - Featured Board Card
struct FeaturedBoardCard: View {
    let board: FeaturedBoard
    var onBoardTapped: ((String) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Card Preview Section with Images
            HStack(alignment: .top, spacing: 2) {
                // Main large image
                Image(board.mainImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 140, maxHeight: .infinity)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 2) {
                    // Top right small image
                    Image(board.smallImages[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .clipped()
                    
                    // Bottom right small image
                    Image(board.smallImages[1])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 70, maxHeight: .infinity)
                        .clipped()
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
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                // Tags Row
                HStack(alignment: .center, spacing: 4) {
                    Text(board.category)
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                    
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(.red))
                    
                    Spacer()
                }
                
                // Stats Row
                HStack(alignment: .center, spacing: 4) {
                    Text("\(board.pinCount) Pins")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    
                    Circle()
                        .frame(width: 2, height: 2)
                        .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    
                    Text(board.timeAgo)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    
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

