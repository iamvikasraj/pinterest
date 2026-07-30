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

    var body: some View {
        // In the SwiftUI canvas, skip instantiating RiveViewModel entirely.
        // Loading the Rive runtime on every preview launch is what pushes the
        // preview past Xcode's 15s launch budget — show a lightweight stand-in
        // instead. The real Rive animation still runs in the simulator/device.
        if isRunningInPreviews {
            RiveSplashPreviewPlaceholder()
        } else {
            RiveSplashRuntime(riveFileName: riveFileName)
        }
    }

    private var isRunningInPreviews: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

// MARK: - Live Rive runtime (device / simulator only)

private struct RiveSplashRuntime: View {
    @StateObject private var viewModel: RiveRuntime.RiveViewModel

    init(riveFileName: String) {
        // fileName = name in app bundle (no path, no extension).
        // Ensure pinterest-splash.riv is in the target’s “Copy Bundle Resources” build phase.
        _viewModel = StateObject(wrappedValue: RiveRuntime.RiveViewModel(fileName: riveFileName))
    }

    var body: some View {
        viewModel.view()
    }
}

// MARK: - Static preview stand-in (no Rive)

private struct RiveSplashPreviewPlaceholder: View {
    var body: some View {
        Image(systemName: "square.grid.2x2.fill")
            .font(.system(size: 56, weight: .bold))
            .foregroundStyle(AppColors.pinterestRed)
            .accessibilityLabel("Splash animation (runs on device)")
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
                LaunchScreenView()
                    .id(restartKey)

                VStack {
                    Spacer()
                    Button("Restart Animation") {
                        restartKey += 1
                    }
                    .padding()
                    .glassEffect()
                    .ignoresSafeArea()
                    
                }
            }
        }
    }
    return PreviewWrapper()
}
