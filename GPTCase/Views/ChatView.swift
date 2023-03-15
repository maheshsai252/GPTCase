//
//  ChatView.swift
//  GPTCase
//
//  Created by Mahesh sai on 3/7/23.
//

import SwiftUI

struct ChatView: View {
    
    @FetchRequest
     var items: FetchedResults<Chat>
    @State var message = ""
    var convo: Conversation
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(items) {item in
                    MessageView(message: item)
                }
            }
                Spacer()
            HStack {
                TextField("message", text: $message)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Spacer()
                Button {
                    
                    ChatHandler.createChat(message: message, convo: convo)
                    Task {
                        await ChatHandler.completenetwork(convo: convo)
                    }
                    message = ""
                } label: {
                    Image(systemName: "paperplane")
                        .padding(.trailing)
                }

            }
                
            .navigationTitle(Text(convo.name ?? ""))
            
        }
    }
}
struct MessageView: View {
    @ObservedObject var message: Chat
    var body: some View {
        HStack(alignment: .bottom) {
            if message.role == "user" {
                Spacer()
            } else {
                Image(systemName: "r.joystick.tilt.right")
                    
            }
            
            Text(AttributedString(message.message ?? ""))
                .padding()
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 20).fill(message.role == "user" ? .blue : .black))
            if message.role != "user" {
                Spacer()
            } else {
                Image(systemName: "person")
                    
            }
        }
    }
}

