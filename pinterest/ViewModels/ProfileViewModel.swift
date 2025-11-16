//
//  ProfileViewModel.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var isSearching = false
    @Published var searchText = ""
    @Published var selectedTab: ProfileTab = .pins
    
    enum ProfileTab: String, CaseIterable {
        case pins = "Pins"
        case boards = "Boards"
        case collage = "Collages"
    }
    
    func toggleSearch() {
        withAnimation {
            isSearching.toggle()
            if !isSearching {
                searchText = ""
            }
        }
    }
    
    func selectTab(_ tab: ProfileTab) {
        selectedTab = tab
    }
}

