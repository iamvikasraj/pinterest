//
//  SearchBar.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Search Bar
struct SearchBar: View {
    var body: some View {
        HStack(spacing: 12) {
            // Magnifying glass icon on the left
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.textSecondary)
                .frame(width: 20, height: 20)
            
            // Search placeholder text
            Text("Search Pinterest")
                .font(Typography.Semantic.searchPlaceholder)
                .foregroundColor(AppColors.textSecondary)
            
            Spacer()
            
            // Camera icon on the right
            Image(systemName: "camera")
                .fontWeight(.regular)
                .foregroundColor(AppColors.textSecondary)
                .frame(width: 20, height: 20)
        }
        .padding(14)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black, lineWidth: 0.5)
        )
    }
}

#Preview {
    SearchBar()
}
