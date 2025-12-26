//
//  dualnbackgameApp.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

import SwiftUI
import CoreData

@main
struct dualnbackgameApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = true
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
