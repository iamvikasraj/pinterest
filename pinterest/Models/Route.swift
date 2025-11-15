//
//  Route.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation

// MARK: - Navigation Routes
enum Route: Hashable {
    // Pin routes
    case pinDetail(pinId: String)
    
    // Board routes
    case boardDetail(boardId: String)
    
    // User routes
    case userProfile(userId: String)
    
    // Message routes
    case messageDetail(messageId: String)
    
    // Settings routes
    case settings
    case editProfile
    
    // Search routes
    case searchResults(query: String)
}

