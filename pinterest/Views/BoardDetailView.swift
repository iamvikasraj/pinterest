//
//  BoardDetailView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct BoardDetailView: View {
    let boardId: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Board Details")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Board ID: \(boardId)")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                // Add board content here
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(0..<10) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 150)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Board")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        BoardDetailView(boardId: "456")
    }
}

