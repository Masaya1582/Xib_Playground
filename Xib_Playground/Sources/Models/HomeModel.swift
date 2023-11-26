//
//  HomeModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonResponse: Codable {
    let results: [Pokemon]
}
