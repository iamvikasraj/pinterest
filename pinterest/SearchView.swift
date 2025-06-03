//
//  searchView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 03/06/25.
//

import SwiftUI

struct searchView: View {
    var body: some View {
        VStack {
            heroContainer()
            featuredBoard(title: "Explore featured boards", bigtitle: "Ideas you might like")
            searchSection(title: "Pouplar on Pinterest", bigtitle: "Hunter 350")
            searchSection(title: "Ideas for you", bigtitle: "Furniture graphics")
            searchSection(title: "Ideas for you", bigtitle: "Mobile Design")
            searchSection(title: "Ideas for you", bigtitle: "Gents shoes")
            searchSection(title: "Popular on Pinterest", bigtitle: "Car edit")
            searchSection(title: "Popular on Pinterest", bigtitle: "Cartoon profile pics")
            searchSection(title: "Ideas for you", bigtitle: "Human poses reference")
        }
        .padding (.bottom, 120)
    }
        
}

#Preview {
    ContentView()
}

struct searchBar: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            HStack(alignment: .bottom, spacing: 6) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 20, height: 20)
                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                Text("Search Pinterest")
                    .font(Font.custom("Inter", size: 16))
                    .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 20, height: 20)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
        }
        .padding(14)
        .frame(width: 378, alignment: .bottomLeading)
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(.black, lineWidth: 1)
        )
    }
}

struct heroContainer: View {
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Made for you")
                    .font(Font.custom("Inter", size: 16))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .top)
                Text("Desi memes for a good laugh")
                    .font(Font.custom("Inter", size: 20))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .top)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(.top, 60)
        .padding(.bottom, 0)
        .frame(width: 393, height: 393, alignment: .center)
        .background(.thinMaterial)
        
        HStack(alignment: .center, spacing: 4) {
            Circle()
                .frame(width: 6, height: 6)
                .foregroundStyle(.black)
            
            ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.76))
            }
            
        }
        .padding(0)
    }
}

struct featuredBoard: View {
    let title: String
    let bigtitle: String
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack(alignment: .center, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(Font.custom("Inter", size: 12))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text(bigtitle)
                            .font(
                                Font.custom("Inter", size: 20)
                                    .weight(.medium)
                            )
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
                    featuredBoardCard()
                    featuredBoardCard()
                    featuredBoardCard()
                    featuredBoardCard()
                    featuredBoardCard()
                }
                .padding(.leading,16)
           }
        }
    }
    
}

struct searchSection: View {
    let title: String
    let bigtitle: String
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack(alignment: .center, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(Font.custom("Inter", size: 12))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text(bigtitle)
                            .font(
                                Font.custom("Inter", size: 20)
                                    .weight(.medium)
                            )
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
                VStack {  }
                    .frame(width: 93, height: 166)
                    .background(Color(red: 0.16, green: 0.16, blue: 0.16))
                
                VStack {  }
                    .frame(width: 93, height: 166)
                    .background(Color(red: 0.16, green: 0.16, blue: 0.16))
                
                VStack {  }
                    .frame(width: 93, height: 166)
                    .background(Color(red: 0.16, green: 0.16, blue: 0.16))
                
                VStack {  }
                    .frame(width: 93, height: 166)
                    .background(Color(red: 0.16, green: 0.16, blue: 0.16))
            }
            .padding(0)
            .frame(maxWidth: 373, alignment: .leading)
            .cornerRadius(16)
            }
        }
    
}

struct featuredBoardCard: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 2) {
                VStack(alignment: .center) {
                
                }
                .padding(10)
                .frame(minWidth: 140, maxHeight: .infinity)
                .background(Color(red: 0.93, green: 0.92, blue: 0.94))
                
                VStack(alignment: .leading, spacing: 2) {
                    VStack(alignment: .leading, spacing: 10) {
                        
                    }
                    .padding(10)
                    .frame(maxWidth: 70, maxHeight: .infinity)
                    .background(Color(red: 0.93, green: 0.92, blue: 0.94))
                    
                    VStack(alignment: .leading, spacing: 10) {
                    
                    }
                    .padding(10)
                    .frame(maxWidth: 70, maxHeight: .infinity)
                    .background(Color(red: 0.93, green: 0.92, blue: 0.94))
                }
                .padding(0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                
            }
            .padding(0)
            .frame(width: 211, height: 142, alignment: .topLeading)
            .background(.white)
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("POV: You’re in New York")
                  .font(
                    Font.custom("Inter", size: 14)
                      .weight(.medium)
                  )
                  .foregroundColor(.black)
                  .frame(maxWidth: .infinity, alignment: .topLeading)
                
                HStack(alignment: .center, spacing: 4) {
                    Text("Collages")
                      .font(Font.custom("Inter", size: 12))
                      .foregroundColor(.black)
                    
                    Circle()
                      .frame(width: 12, height: 12)
                      .background(Color(red: 0.89, green: 0, blue: 0.14))
                    
                    Text("+ 1")
                      .font(Font.custom("Inter", size: 12))
                      .foregroundColor(.black)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(alignment: .center, spacing: 4) {
                    Text("14 Pins")
                      .font(Font.custom("Inter", size: 12))
                      .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                    Circle()
                      .frame(width: 2, height: 2)
                      .background(Color(red: 0.39, green: 0.39, blue: 0.38))
                    Text("8mo")
                      .font(Font.custom("Inter", size: 12))
                      .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))
                }
                .padding(0)
            }
            .padding(.horizontal, 8)
            .padding(.vertical,2)
            .frame(width: 195, alignment: .topLeading)
        }
    }
}
