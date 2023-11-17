//
//  Pokemon.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/11/17.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonResponse: Codable {
    let results: [Pokemon]
}
