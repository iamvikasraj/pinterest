//
//  chatView.swift
//  pinterest
//
//  Created by Vikas Raj Yadav on 04/06/25.
//

import SwiftUI

// MARK: - Data Models
struct MessageData: Identifiable, Codable {
    var id = UUID()
    let senderName: String
    let messagePreview: String
    let timestamp: String
}

struct UpdateData: Identifiable, Codable {
    var id = UUID()
    let message: String
    let imageName: String
}

// MARK: - Mock Data Service
class MockDataService: ObservableObject {
    @Published var messages: [MessageData] = []
    @Published var updates: [UpdateData] = []
    @Published var isLoading = false
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.messages = [
                MessageData(senderName: "Pinterest", messagePreview: "Sent a Pin!", timestamp: "3y"),
                MessageData(senderName: "Design Team", messagePreview: "New board shared", timestamp: "1d")
            ]
            
            self.updates = [
                UpdateData(message: "New pins added to your Home feed", imageName: "one"),
                UpdateData(message: "Weekly trends: Minimalist design is trending", imageName: "two"),
                UpdateData(message: "Your board 'Kitchen Ideas' got 50 new saves", imageName: "three"),
                UpdateData(message: "Recommended: Summer fashion pins", imageName: "fourth"),
                UpdateData(message: "Pin performance: Your latest pin reached 1K views", imageName: "one")
            ]
            
            self.isLoading = false
        }
    }
    
    func refreshData() {
        loadMockData()
    }
}

struct chatView: View {
    @StateObject private var dataService = MockDataService()
    
    var body: some View {
        ZStack() {
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
            
            // Content area
            Spacer()
        }
        .padding(.top, 80)
        
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
            
            if dataService.isLoading {
                ProgressView()
                    .frame(height: 80)
            } else {
                ForEach(dataService.messages) { message in
                    messageCard(messageData: message)
                }
            }
        }
        .padding(16)
        .background(.white)
        
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
            
            if dataService.isLoading {
                ProgressView()
                    .frame(height: 200)
            } else {
                ForEach(dataService.updates) { update in
                    updatesCard(message: update.message, image: update.imageName)
                }
            }
        }
        .padding(16)
        .background(.white)
        .onAppear {
            if dataService.updates.isEmpty && dataService.messages.isEmpty {
                dataService.loadMockData()
            }
        }
        .refreshable {
            dataService.refreshData()
        }
    }
}

#Preview {
    chatView()
}

struct messageCard: View {
    let messageData: MessageData
    
    // Default initializer for backward compatibility
    init() {
        self.messageData = MessageData(senderName: "Pinterest India", messagePreview: "Sent a Pin!", timestamp: "3y")
    }
    
    // New initializer with data
    init(messageData: MessageData) {
        self.messageData = messageData
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Text(String(messageData.senderName.prefix(1)))
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(width: 46, height: 46)
            .background(Color(red: 0.91, green: 0.9, blue: 0.88))
            .cornerRadius(11)
            
            VStack(spacing: 4) {
                Text(messageData.senderName)
                    .font(
                        Font.custom("Inter", size: 15)
                            .weight(.medium)
                    )
                    .kerning(0.15)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text(messageData.messagePreview)
                    .font(Font.custom("Inter", size: 15))
                    .kerning(0.15)
                    .foregroundColor(Color(red: 0.59, green: 0.57, blue: 0.57))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            
            Spacer()
            
            Text(messageData.timestamp)
                .font(Font.custom("Inter", size: 12))
                .kerning(0.12)
                .foregroundColor(Color(red: 0.59, green: 0.57, blue: 0.57))
        }
        .padding(.top, 16)
        .contentShape(Rectangle())
        .onTapGesture {
            print("Message from \(messageData.senderName) tapped")
        }
    }
}

struct updatesCard: View {
    let message: String
    let image: String
    
    var body: some View {
        HStack {
            ZStack {
                // Show SF Symbol as placeholder for image
                Image(image)
                    .foregroundColor(.gray)
                    .font(.title2)
            }
            .frame(width: 46, height: 64)
            .background(Color(red: 0.91, green: 0.9, blue: 0.88))
            .cornerRadius(8)
            
            Text(message)
                .font(
                    Font.custom("Inter", size: 15)
                        .weight(.medium)
                )
                .kerning(0.15)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            Button(action: {
                print("More options for: \(message)")
            }) {
                Image(systemName: "ellipsis")
                    .frame(width: 14, height: 24)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .onTapGesture {
            print("Update tapped: \(message)")
        }
    }
}
