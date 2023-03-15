//
//  Network.swift
//  GPTCase
//
//  Created by Mahesh sai on 3/5/23.
//

import Foundation

struct Network {
    
    static func fetchChat(chats: [Chat]) async throws -> ChatResponse? {
        var bearerToken = ""
        if let key = Bundle.main.infoDictionary?["API_KEY"] as? String {
            bearerToken = key
            print(key)
        }
            
            
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { fatalError("Missing URL")
            
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        var cs: [[String: String]] = []
        for chat in chats {
            cs.append(["role": chat.role ?? "", "content": chat.message ?? ""])
        }
//        [["role": "user", "content": "Hello!"]]
        let jsonbody: [String: Any] = [
            "model": "gpt-3.5-turbo" ,
            "messages": cs
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonbody)

        urlRequest.httpBody = jsonData
        urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print(response)
            print(data)
//        }
        let chatresponse = try JSONDecoder().decode(ChatResponse.self, from: data)
        return chatresponse
    }
}
