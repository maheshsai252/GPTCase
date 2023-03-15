//
//  Models.swift
//  GPTCase
//
//  Created by Mahesh sai on 3/5/23.
//

import Foundation

struct ChatResponse: Codable {
    let id: String?
    let object: String?
    let created: Int?
    let choices: [Choice]?
    
}
struct Message: Codable {
    let role: String?
    let content: String?
}
struct Choice: Codable {
    let index: Int?
    let message: Message?
    let finish_reason: String?
}
