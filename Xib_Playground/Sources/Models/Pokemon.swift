//
//  Pokemon.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2024/01/03.
//

import Foundation

struct Pokemon {
    var name: String
    var level: Int
    var type: String

    mutating func evolve() {
        if name == "Charmander" && level >= 16 {
            name = "Charmeleon"
            type = "Fire"
            print("\(name) has evolved")
        } else if name == "Chameleon" && level >= 36 {
            name = "Charizard"
            type = "Fire/Flying"
            print("\(name) has evolved")
        } else {
            print("\(name) cannot evolve yet.")
        }
    }
}
