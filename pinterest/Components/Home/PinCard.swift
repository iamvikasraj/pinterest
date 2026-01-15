//
//  PinCard.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI
import UIKit

// MARK: - Pin Card
struct PinCard: View {
    let pin: Pin
    let namespace: Namespace.ID
    let selectedPinId: String
    let onMoreTapped: () -> Void
    var onPinTapped: ((String, String, CGRect) -> Void)? = nil
    @State private var cardFrame: CGRect = .zero
    @State private var aspectRatio: CGFloat = 1.5
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Group {
                if !pin.imageName.isEmpty {
                    Image(pin.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .background(Color(red: 0.73, green: 0.73, blue: 0.73))
                        .cornerRadius(16)
                        .clipped()
                        .matchedGeometryEffect(id: pin.id.uuidString, in: namespace)
                } else {
                    // Placeholder when image name is empty
                    Rectangle()
                        .fill(Color(red: 0.73, green: 0.73, blue: 0.73))
                        .cornerRadius(16)
                }
            }
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: PinCardFramePreferenceKey.self, value: geometry.frame(in: .global))
                }
            )
            .onPreferenceChange(PinCardFramePreferenceKey.self) { frame in
                cardFrame = frame
            }
            .onTapGesture {
                onPinTapped?(pin.id.uuidString, pin.imageName, cardFrame)
            }
            
            // Pin icon overlay in bottom-right corner
            Image("more")
                .padding(.top,4)
                .onTapGesture {
                    onMoreTapped()
                }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .onAppear {
            loadImageAspectRatio()
        }
    }
    
    private func loadImageAspectRatio() {
        guard let image = UIImage(named: pin.imageName) else {
            aspectRatio = 1.5
            return
        }
        let width = image.size.width / image.scale
        let height = image.size.height / image.scale
        aspectRatio = height / width
    }
}

// MARK: - Previews
#Preview("Pin Card") {
    struct PreviewWrapper: View {
        @Namespace private var namespace
        let samplePin = Pin(imageName: "one", title: "Sample Pin")
        
        var body: some View {
            PinCard(
                pin: samplePin,
                namespace: namespace,
                selectedPinId: "",
                onMoreTapped: {
                    print("More tapped")
                },
                onPinTapped: { pinId, imageName, frame in
                    print("Pin tapped: \(pinId)")
                }
            )
            .padding()
        }
    }
    
    return PreviewWrapper()
}

#Preview("Pin Card - Selected") {
    struct PreviewWrapper: View {
        @Namespace private var namespace
        let samplePin = Pin(imageName: "two", title: "Selected Pin")
        
        var body: some View {
            PinCard(
                pin: samplePin,
                namespace: namespace,
                selectedPinId: samplePin.id.uuidString,
                onMoreTapped: {
                    print("More tapped")
                },
                onPinTapped: { pinId, imageName, frame in
                    print("Pin tapped: \(pinId)")
                }
            )
            .padding()
        }
    }
    
    return PreviewWrapper()
}

#Preview("Pin Card Grid") {
    struct PreviewWrapper: View {
        @Namespace private var namespace
        let pins = [
            Pin(imageName: "one"),
            Pin(imageName: "two"),
            Pin(imageName: "three"),
            Pin(imageName: "fourth")
        ]
        
        var body: some View {
            ScrollView {
                HStack(alignment: .top, spacing: 8) {
                    VStack(spacing: 8) {
                        ForEach(Array(pins.enumerated()).filter { $0.offset % 2 == 0 }, id: \.element.id) { _, pin in
                            PinCard(
                                pin: pin,
                                namespace: namespace,
                                selectedPinId: "",
                                onMoreTapped: {
                                    print("More tapped")
                                },
                                onPinTapped: { pinId, imageName, frame in
                                    print("Pin tapped: \(pinId)")
                                }
                            )
                        }
                    }
                    
                    VStack(spacing: 8) {
                        ForEach(Array(pins.enumerated()).filter { $0.offset % 2 == 1 }, id: \.element.id) { _, pin in
                            PinCard(
                                pin: pin,
                                namespace: namespace,
                                selectedPinId: "",
                                onMoreTapped: {
                                    print("More tapped")
                                },
                                onPinTapped: { pinId, imageName, frame in
                                    print("Pin tapped: \(pinId)")
                                }
                            )
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    return PreviewWrapper()
}
