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
    let onMoreTapped: () -> Void
    var onPinTapped: ((String, String, CGRect) -> Void)? = nil
    @State private var cardFrame: CGRect = .zero
    @State private var aspectRatio: CGFloat = 1.5
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(pin.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color(red: 0.73, green: 0.73, blue: 0.73))
                .cornerRadius(16)
                .clipped()
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
                .padding(8)
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
