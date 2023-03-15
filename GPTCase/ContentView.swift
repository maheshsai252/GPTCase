//
//  ContentView.swift
//  GPTCase
//
//  Created by Mahesh sai on 3/5/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    

    var body: some View {
        NavigationView {
            ConvoView()
            
            .task {
//                do {
//                    try await print(Network.fetchChat())
//                } catch {
//                    print(error)
//                }
            }
            .toolbar {
#if os(iOS)
              
#endif

            }
        }
    }

    

   
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
