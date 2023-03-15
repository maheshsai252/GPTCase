//
//  ChatHandler.swift
//  GPTCase
//
//  Created by Mahesh sai on 3/7/23.
//

import Foundation

struct ChatHandler {
    static var context = PersistenceController.shared.container.viewContext
    
    static func createChat(message: String, role: String = "user", convo: Conversation) {
        let c = Chat(context: context)
        c.message = message
        c.role = role
        c.date = Date()
        c.convo = convo
        ChatHandler.save()
    }
    static func createConvo(name: String) {
        let c = Conversation(context: context)
        c.name = name
        ChatHandler.save()
    }
    static func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    static func completenetwork(convo: Conversation) async {
        do {
            let res = try await Network.fetchChat(chats: ChatHandler.fetchAllChats())
            if !(res?.choices?.isEmpty ?? true) {
                ChatHandler.createChat(message: res?.choices?[0].message?.content ?? "error", role: "assistant", convo: convo)
                
            }
        } catch  {
            print(error)
        }
        
    }
    static func fetchAllChats() -> [Chat] {
        var c: [Chat] = []
        
        let fr = Chat.fetchRequest()
        fr.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            c = try context.fetch(fr)
        }
        catch {
            print(error)
        }
        return c
        
    }
}
