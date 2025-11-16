//
//  ChatCards.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

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
                    .font(Typography.Body.medium.weight(.medium))
                    .kerning(0.15)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text(message.messagePreview)
                    .font(Typography.Body.medium)
                    .kerning(0.15)
                    .foregroundColor(AppColors.textTertiary)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            
            Spacer()
            
            Text(message.timestamp)
                .font(Typography.Caption.large)
                .kerning(0.12)
                .foregroundColor(AppColors.textTertiary)
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
                .font(Typography.Body.medium.weight(.medium))
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
