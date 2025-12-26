//
//  GameConfig.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

import Foundation

struct GameConfig: Equatable {
    var nth: Int
    var length: Int
    var trialDuration: TimeInterval
    var targetRate: Double
}

extension GameConfig {
    static let `default` = GameConfig(
        nth: 2,
        length: 20,
        trialDuration: 3.5,
        targetRate: 0.80
    )
}
