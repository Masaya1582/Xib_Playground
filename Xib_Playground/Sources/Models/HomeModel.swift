//
//  HomeModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

final class HomeModel {
    var name: String
    var age: Int
    var height: Double
    var isHuman: Bool

    init(name: String, age: Int, height: Double, isHuman: Bool) {
        self.name = name
        self.age = age
        self.height = height
        self.isHuman = isHuman
    }

    func pokemonAttack(type: String, attack: String) {
        print("\(type) type Pokemon used \(attack)!")

    }
}
