//
//  MessageDetailView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct MessageDetailView: View {
    let messageId: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Message Details")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Message ID: \(messageId)")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                // Message content
                VStack(alignment: .leading, spacing: 12) {
                    Text("Message Preview")
                        .font(.headline)
                    
                    Text("This is the detailed view of the message. You can add message content, replies, and other details here.")
                        .font(.body)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle("Message")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MessageDetailView(messageId: "msg123")
    }
}

