//
//  DualNBackSettingsViewModel.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

import Foundation
import CoreData
import Combine

final class DualNBackSettingsViewModel: ObservableObject {
    @Published var config: GameConfig

    private let context: NSManagedObjectContext
    private let gameEntity: GameSettings

    init(context: NSManagedObjectContext) {
        self.context = context

        let request: NSFetchRequest<GameSettings> = GameSettings.fetchRequest()
        request.fetchLimit = 1

        if let existing = try? context.fetch(request).first {
            self.gameEntity = existing
        } else {
            let entity = GameSettings(context: context)
            entity.nth = 2
            entity.length = 20
            entity.trialDuration = 2.0
            entity.targetRate = 0.2

            self.gameEntity = entity

            try? context.save()
        }

        self.config = GameConfig(
            nth: Int(gameEntity.nth),
            length: Int(gameEntity.length),
            trialDuration: gameEntity.trialDuration,
            targetRate: gameEntity.targetRate
        )
    }

    func save() {
        gameEntity.nth = Int16(config.nth)
        gameEntity.length = Int16(config.length)
        gameEntity.trialDuration = config.trialDuration
        gameEntity.targetRate = config.targetRate

        do {
            try context.save()
        } catch {
            assertionFailure("Failed to save DualNBack settings: \(error)")
        }
    }
}
