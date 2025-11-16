//
//  SearchSections.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

// MARK: - Featured Board View
struct FeaturedBoardView: View {
    let title: String
    let bigTitle: String
    let boards: [FeaturedBoard]
    var onBoardTapped: ((String) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Typography.Caption.large)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text(bigTitle)
                        .font(Typography.Semantic.carouselSubtitle)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 16)
            .padding(.top, 30)
            .frame(width: 393, alignment: .topLeading)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(boards) { board in
                        FeaturedBoardCard(
                            board: board,
                            onBoardTapped: { boardId in
                                onBoardTapped?(boardId)
                            }
                        )
                    }
                }
                .padding(.leading, 16)
            }
        }
    }
}

// MARK: - Search Section View
struct SearchSectionView: View {
    let title: String
    let bigTitle: String
    let images: [String]
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Typography.Caption.large)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text(bigTitle)
                        .font(Typography.Semantic.carouselSubtitle)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Image("chevron")
                    .frame(height: 42, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.top, 30)
            .frame(width: 393, alignment: .topLeading)
            
            HStack(alignment: .center, spacing: 2) {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 93, height: 166)
                        .clipped()
                }
            }
            .padding(0)
            .frame(maxWidth: 373, alignment: .leading)
            .cornerRadius(16)
        }
    }
}
