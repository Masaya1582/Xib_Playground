//
//  Pokemon.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/12/07.
//

import Foundation

struct Pokemon {
    var name: String
    var attack: Int
    var level: Int
    var defence: Int
    var type: String

    var combatPower: Int {
        get {
            return (level * attack * defence) / 10
        }
        set(newCP) {
            let newStats = newCP * 10 / level
            attack = Int(sqrt(Double(newStats)))
            defence = Int(sqrt(Double(newStats)))
        }
    }
}
