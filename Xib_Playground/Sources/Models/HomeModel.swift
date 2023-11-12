//
//  Pokemon.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

protocol PokemonBehavior {
    var name: String { get }
    var level: Int { get set }

    func attack()
    func heal()
}

final class Pikachu: PokemonBehavior {
    var name: String = "Pikachu"
    var level: Int = 10

    func attack() {
        print("Pikachu used Thunderbolt!")
    }

    func heal() {
        print("Pikachu used Potion.")
    }
}
