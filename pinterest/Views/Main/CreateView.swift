//
//  CreateView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct CreateView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Create")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .padding(.vertical, 80)
    }
}

#Preview("Create View") {
    CreateView()
}

#Preview("Create View - Dark Mode") {
    CreateView()
        .preferredColorScheme(.dark)
}

