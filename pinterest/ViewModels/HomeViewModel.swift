//
//  HomeViewModel.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var pins: [Pin] = []
    @Published var isLoading = false
    
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
        loadPins()
    }
    
    func loadPins() {
        isLoading = true
        DispatchQueue.main.async {
            self.pins = self.dataService.fetchPins()
            self.isLoading = false
        }
    }
}

