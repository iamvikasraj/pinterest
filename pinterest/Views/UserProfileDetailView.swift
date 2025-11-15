//
//  UserProfileDetailView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct UserProfileDetailView: View {
    let userId: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Header
                VStack(spacing: 12) {
                    Image("profile")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text("User Profile")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("User ID: \(userId)")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // User Content
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 8) {
                    ForEach(0..<15) { index in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 120)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        UserProfileDetailView(userId: "789")
    }
}

