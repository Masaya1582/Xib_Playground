//
//  HomeModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

enum PokemonType {
    case fire
    case water
    case grass
    case electric
}

struct Pokemon {
    var name: String
    var type: PokemonType
}
