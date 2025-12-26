//
//  DualNBackSettingsView.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

import SwiftUI
import SwiftUI
import CoreData

struct DualNBackSettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var vm: DualNBackSettingsViewModel

    init() {
        _vm = StateObject(wrappedValue: DualNBackSettingsViewModel(context: PersistenceController.shared.container.viewContext))
    }

    var body: some View {
        Form {
            GameConfigForm(config: $vm.config)
        }
        .onDisappear {
            vm.save()
        }
        .navigationTitle("Dual N-Back Settings")
    }
}
