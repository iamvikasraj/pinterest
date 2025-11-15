//
//  SearchSection.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation

struct SearchSection: Identifiable {
    let id: UUID
    let title: String
    let bigTitle: String
    let images: [String]
    
    init(id: UUID = UUID(), title: String, bigTitle: String, images: [String]) {
        self.id = id
        self.title = title
        self.bigTitle = bigTitle
        self.images = images
    }
}

