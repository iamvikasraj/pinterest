//
//  DesignSystem.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Typography Style Guide
struct Typography {
    // MARK: - Display Styles
    struct Display {
        static let large = Font.system(size: 32, weight: .bold)
        static let medium = Font.system(size: 28, weight: .bold)
        static let small = Font.system(size: 24, weight: .bold)
    }
    
    // MARK: - Title Styles
    struct Title {
        static let large = Font.system(size: 20, weight: .medium)
        static let medium = Font.system(size: 16, weight: .medium)
        static let small = Font.system(size: 16, weight: .medium)
    }
    
    // MARK: - Body Styles
    struct Body {
        static let large = Font.system(size: 16, weight: .regular)
        static let medium = Font.system(size: 16, weight: .regular)
        static let small = Font.system(size: 16, weight: .regular)
    }
    
    // MARK: - Caption Styles
    struct Caption {
        static let xlarge = Font.system(size: 15, weight: .medium)
        static let large = Font.system(size: 12, weight: .regular)
        static let medium = Font.system(size: 12, weight: .regular)
        static let small = Font.system(size: 12, weight: .regular)
        static let xs = Font.system(size: 10, weight: .semibold)
    }
    
    // MARK: - Label Styles
    struct Label {
        static let large = Font.system(size: 16, weight: .semibold)
        static let medium = Font.system(size: 16, weight: .semibold)
        static let small = Font.system(size: 16, weight: .semibold)
    }
    
    // MARK: - Semantic Styles (Common Use Cases)
    struct Semantic {
        // Headers
        static let pageTitle = Font.system(size: 20, weight: .semibold)
        static let sectionTitle = Font.system(size: 16, weight: .semibold)
        static let subsectionTitle = Font.system(size: 16, weight: .medium)
        
        // Content
        static let cardTitle = Font.system(size: 16, weight: .medium)
        static let cardBody = Font.system(size: 16, weight: .regular)
        static let cardCaption = Font.system(size: 12, weight: .regular)
        
        // Navigation
        static let navTitle = Font.system(size: 20, weight: .semibold)
        static let navItem = Font.system(size: 16, weight: .semibold)
        static let tabLabel = Font.system(size: 16, weight: .semibold)
        
        // Search
        static let searchPlaceholder = Font.system(size: 16, weight: .regular)
        static let searchTitle = Font.system(size: 24, weight: .bold)
        
        // Carousel
        static let carouselTitle = Font.system(size: 16, weight: .medium)
        static let carouselSubtitle = Font.system(size: 20, weight: .medium)
        
        // Overlay
        static let overlayOption = Font.system(size: 16, weight: .regular)
    }
}

// MARK: - Color System
struct AppColors {
    // Brand Colors
    static let pinterestRed = Color(red: 0.85, green: 0.0, blue: 0.0)
    
    // Text Colors
    static let textPrimary = Color.black
    static let textSecondary = Color(red: 0.39, green: 0.39, blue: 0.38)
    static let textTertiary = Color(red: 0.59, green: 0.57, blue: 0.57)
    
    // Background Colors
    static let backgroundPrimary = Color.white
    static let backgroundSecondary = Color(red: 0.91, green: 0.9, blue: 0.88)
    static let backgroundTertiary = Color(red: 0.73, green: 0.73, blue: 0.73)
    
    // UI Colors
    static let borderGray = Color(red: 0.85, green: 0.85, blue: 0.85)
    static let indicatorGray = Color(red: 0.78, green: 0.78, blue: 0.76)
}

// MARK: - Spacing System
struct Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let xxxl: CGFloat = 32
}

// MARK: - Corner Radius
struct CornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let xlarge: CGFloat = 20
    static let round: CGFloat = 24
}

// MARK: - Shadow Styles
struct Shadow {
    static let small = (color: Color.black.opacity(0.1), radius: 4.0, x: 0.0, y: 4.0)
    static let medium = (color: Color.black.opacity(0.15), radius: 8.0, x: 0.0, y: 4.0)
    static let large = (color: Color.black.opacity(0.1), radius: 20.0, x: 0.0, y: -4.0)
}

