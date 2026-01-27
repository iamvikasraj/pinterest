//
//  LaunchScreenView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 04/06/25.
//

import SwiftUI
import RiveRuntime

struct LaunchScreenView: View {
    /// Name of the .riv file in the app bundle (without extension).
    /// File is at pinterest/Resources/pinterest-splash.riv
    /// Must be in the app target’s “Copy Bundle Resources” build phase.
    private let riveFileName: String

    init(riveFileName: String = "pinterest-splash") {
        self.riveFileName = riveFileName
    }

    var body: some View {
        ZStack {
            // Background color matching Pinterest's brand
            Color.white
                .ignoresSafeArea()

            // Rive animation – full screen, centered
            RiveSplashContent(riveFileName: riveFileName)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Rive content

private struct RiveSplashContent: View {
    let riveFileName: String
    @StateObject private var viewModel: RiveRuntime.RiveViewModel

    init(riveFileName: String) {
        self.riveFileName = riveFileName
        // fileName = name in app bundle (no path, no extension).
        // Ensure pinterest-splash.riv is in the target’s “Copy Bundle Resources” build phase.
        _viewModel = StateObject(wrappedValue: RiveRuntime.RiveViewModel(fileName: riveFileName))
    }

    var body: some View {
        viewModel.view()
    }
}

#Preview {
    LaunchScreenView()
}

#Preview("With Restart Button") {
    struct PreviewWrapper: View {
        @State private var restartKey = 0

        var body: some View {
            ZStack {
                VStack {
                    LaunchScreenView()
                        .id(restartKey)

                    Button("Restart Animation") {
                        restartKey += 1
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top, 50)
                }
            }
        }
    }
    return PreviewWrapper()
}
