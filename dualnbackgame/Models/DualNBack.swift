//
//  DualNBack.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

import Foundation

enum GridPos: Int, CaseIterable {
    case p0, p1, p2, p3, p4, p5, p6, p7, p8
    static func random() -> GridPos { GridPos.allCases.randomElement()! }
}

struct Stimulus: Identifiable, Equatable {
    let id = UUID()
    let position: GridPos
    let sound: SoundToken
}

struct Trial: Identifiable {
    let id = UUID()
    let stimulus: Stimulus
    let isPosTarget: Bool
    let isSoundTarget: Bool
}

struct TrialResult {
    let posResponse: Bool
    let soundResponse: Bool
    let posCorrect: Bool
    let soundCorrect: Bool
}
