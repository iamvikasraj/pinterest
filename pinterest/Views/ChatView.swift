//
//  ChatView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 04/06/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    var onNavigate: ((Route) -> Void)? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Inbox")
                        .font(.custom("Inter", size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        print("New message tapped")
                    }) {
                        Image("new message")
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                    }
                }
                .padding(16)
                .background(.white)
                .shadow(color: .gray.opacity(0.0), radius: 4, x: 0, y: 2)
                
                // Messages Section
                VStack {
                    HStack {
                        Text("Messages")
                            .font(.custom("Inter", size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Text("See all")
                            .font(.custom("Inter", size: 12))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Button(action: {
                            print("Messages see all tapped")
                        }) {
                            Image(systemName: "chevron.right")
                                .frame(width: 14, height: 24)
                                .foregroundColor(.black)
                        }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(height: 80)
                    } else {
                        ForEach(viewModel.messages) { message in
                            MessageCard(
                                message: message,
                                onMessageTapped: { messageId in
                                    onNavigate?(.messageDetail(messageId: messageId))
                                }
                            )
                        }
                    }
                }
                .padding(16)
                .background(.white)
                
                // Updates Section
                VStack {
                    HStack {
                        Text("Updates")
                            .font(.custom("Inter", size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Text("See all")
                            .font(.custom("Inter", size: 12))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Button(action: {
                            print("Updates see all tapped")
                        }) {
                            Image(systemName: "chevron.right")
                                .frame(width: 14, height: 24)
                                .foregroundColor(.black)
                        }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(height: 200)
                    } else {
                        ForEach(viewModel.updates) { update in
                            UpdateCard(update: update)
                        }
                    }
                }
                .padding(16)
                .background(.white)
            }
        }
        .refreshable {
            viewModel.refreshData()
        }
    }
}

#Preview {
    ChatView()
}
