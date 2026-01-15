//
//  Pin.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation

struct Pin: Identifiable, Codable {
    let id: UUID
    let imageName: String
    let title: String?
    let description: String?
    let aspectRatio: CGFloat?
    let fixedHeight: CGFloat?
    
    init(id: UUID = UUID(), imageName: String, title: String? = nil, description: String? = nil, aspectRatio: CGFloat? = nil, fixedHeight: CGFloat? = nil) {
        self.id = id
        self.imageName = imageName
        self.title = title
        self.description = description
        self.aspectRatio = aspectRatio
        self.fixedHeight = fixedHeight
    }
}

