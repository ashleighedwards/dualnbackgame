//
//  SoundToken.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

enum SoundToken: String, CaseIterable {
    case A, B, C, D, E, F, G, H
    static func random() -> SoundToken { SoundToken.allCases.randomElement()! }
}
