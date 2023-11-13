//
//  Pokemon.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

final class Pokemon {
    var name: String

    init(name: String) {
        self.name = name
        print("Pokemon \(name) has joined the training camp.")
    }

    deinit {
        print("Pokemon \(name) has left the training camp.")
    }

}
