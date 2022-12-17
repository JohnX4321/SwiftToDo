//
//  SwiftToDoApp.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI

@main
struct SwiftToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}