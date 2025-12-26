//
//  ContentView.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            DualNBackView()
                .tabItem {
                    Label("Dual N-Back", systemImage: "puzzlepiece")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
