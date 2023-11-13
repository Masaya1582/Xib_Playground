//
//  Pokemon.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

struct Pokemon {
    let name: String
    var evolution: String?

    init(name: String, evolution: String? = nil) {
        self.name = name
        self.evolution = evolution
    }
}
