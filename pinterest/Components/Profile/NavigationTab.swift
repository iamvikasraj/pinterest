//
//  NavigationTab.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Navigation Tab (for Profile)
struct NavigationTab: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Text(title)
            .font(Typography.Semantic.navItem)
            .foregroundColor(isSelected ? AppColors.textPrimary : AppColors.textSecondary)
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .onTapGesture {
                onTap()
            }
    }
}
