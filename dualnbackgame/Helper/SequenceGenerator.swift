//
//  SequenceGenerator.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

struct SequenceGenerator {
    static func makeTrials(length: Int, n: Int, targetRate: Double) -> [Trial] {
        precondition(length > n, "Length must exceed n")

        var positions = (0..<length).map { _ in GridPos.random() }
        var sounds = (0..<length).map { _ in SoundToken.random() }

        var posTargets = Array(repeating: false, count: length)
        var soundTargets = Array(repeating: false, count: length)

        for i in n..<length {
            if Double.random(in: 0...1) < targetRate {
                positions[i] = positions[i - n]
                posTargets[i] = true
            } else {
                var newPos: GridPos
                repeat { newPos = GridPos.random() } while newPos == positions[i - n]
                positions[i] = newPos
                posTargets[i] = false
            }

            if Double.random(in: 0...1) < targetRate {
                sounds[i] = sounds[i - n]
                soundTargets[i] = true
            } else {
                var newSound: SoundToken
                repeat { newSound = SoundToken.random() } while newSound == sounds[i - n]
                sounds[i] = newSound
                soundTargets[i] = false
            }
        }

        return (0..<length).map { i in
            Trial(
                stimulus: Stimulus(position: positions[i], sound: sounds[i]),
                isPosTarget: posTargets[i],
                isSoundTarget: soundTargets[i]
            )
        }
    }
}
