//
//  EditProfileView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct EditProfileView: View {
    @State private var username = "User"
    @State private var bio = ""
    
    var body: some View {
        Form {
            Section("Profile Information") {
                TextField("Username", text: $username)
                TextField("Bio", text: $bio, axis: .vertical)
                    .lineLimit(3...6)
            }
            
            Section {
                Button("Save Changes") {
                    // Save profile
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
    }
}

