//
//  ChatViewModel.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var updates: [Update] = []
    @Published var isLoading = false
    
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
        loadData()
    }
    
    func loadData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.messages = self.dataService.fetchMessages()
            self.updates = self.dataService.fetchUpdates()
            self.isLoading = false
        }
    }
    
    func refreshData() {
        loadData()
    }
}

