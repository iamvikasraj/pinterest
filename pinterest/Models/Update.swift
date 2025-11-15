//
//  Update.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation

struct Update: Identifiable, Codable {
    let id: UUID
    let message: String
    let imageName: String
    
    init(id: UUID = UUID(), message: String, imageName: String) {
        self.id = id
        self.message = message
        self.imageName = imageName
    }
}

