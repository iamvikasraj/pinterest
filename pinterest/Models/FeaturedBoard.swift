//
//  FeaturedBoard.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation

struct FeaturedBoard: Identifiable {
    let id: UUID
    let title: String
    let category: String
    let pinCount: Int
    let timeAgo: String
    let mainImage: String
    let smallImages: [String]
    let colorHex: String
    
    init(id: UUID = UUID(), title: String, category: String, pinCount: Int, timeAgo: String, mainImage: String, smallImages: [String], colorHex: String) {
        self.id = id
        self.title = title
        self.category = category
        self.pinCount = pinCount
        self.timeAgo = timeAgo
        self.mainImage = mainImage
        self.smallImages = smallImages
        self.colorHex = colorHex
    }
}

