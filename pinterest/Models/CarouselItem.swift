//
//  CarouselItem.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation

struct CarouselItem: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let backgroundImage: String
    
    init(id: UUID = UUID(), title: String, subtitle: String, backgroundImage: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.backgroundImage = backgroundImage
    }
}

