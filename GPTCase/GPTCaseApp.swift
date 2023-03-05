//
//  GPTCaseApp.swift
//  GPTCase
//
//  Created by Mahesh sai on 3/5/23.
//

import SwiftUI

@main
struct GPTCaseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
