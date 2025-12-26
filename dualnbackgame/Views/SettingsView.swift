//
//  SettingsView.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Enable Dark Mode", isOn: $isDarkMode)
                    .pickerStyle(SegmentedPickerStyle())
                }
            
                Section(header: Text("Dual N-back")) {
                    NavigationLink(destination: DualNBackSettingsView()) {
                        Text("Change game settings")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
