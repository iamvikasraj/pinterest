//
//  PinDetailView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct PinDetailView: View {
    let pinId: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Pin Image
                Image("one") // Replace with actual pin image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(16)
                
                // Pin Details
                VStack(alignment: .leading, spacing: 12) {
                    Text("Pin Details")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Pin ID: \(pinId)")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Text("This is a detailed view of the pin. You can add more information here like description, comments, related pins, etc.")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("Pin")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PinDetailView(pinId: "123")
    }
}

