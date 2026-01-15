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
    var namespace: Namespace.ID? = nil
    var tabId: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .font(Typography.Semantic.navItem)
                .foregroundColor(isSelected ? AppColors.textPrimary : AppColors.textSecondary)
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
            
            // Underline indicator for active tab - always reserve space
            Group {
                if let namespace = namespace {
                    Rectangle()
                        .fill(AppColors.textPrimary)
                        .frame(height: 2)
                        .padding(.top, 4)
                        .opacity(isSelected ? 1 : 0)
                        .matchedGeometryEffect(id: "underline", in: namespace, isSource: isSelected)
                } else {
                    Rectangle()
                        .fill(AppColors.textPrimary)
                        .frame(height: 2)
                        .padding(.top, 4)
                        .opacity(isSelected ? 1 : 0)
                }
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .onTapGesture {
            onTap()
        }
    }
}
