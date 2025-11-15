//
//  SettingsView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section("Account") {
                NavigationLink("Edit Profile", value: Route.editProfile)
                Text("Privacy")
                Text("Security")
            }
            
            Section("Preferences") {
                Text("Notifications")
                Text("Language")
                Text("Theme")
            }
            
            Section("About") {
                Text("Version 1.0")
                Text("Terms of Service")
                Text("Privacy Policy")
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(for: Route.self) { route in
            if route == .editProfile {
                EditProfileView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

