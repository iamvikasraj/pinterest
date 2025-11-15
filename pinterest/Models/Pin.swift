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
    
    init(id: UUID = UUID(), imageName: String, title: String? = nil, description: String? = nil) {
        self.id = id
        self.imageName = imageName
        self.title = title
        self.description = description
    }
}

