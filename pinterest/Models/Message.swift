//
//  Message.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: UUID
    let senderName: String
    let messagePreview: String
    let timestamp: String
    
    init(id: UUID = UUID(), senderName: String, messagePreview: String, timestamp: String) {
        self.id = id
        self.senderName = senderName
        self.messagePreview = messagePreview
        self.timestamp = timestamp
    }
}

