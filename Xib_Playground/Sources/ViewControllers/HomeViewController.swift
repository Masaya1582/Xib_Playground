//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    private let charmander = Pokemon(name: "Charmander", type: .fire)
    private let squirtle = Pokemon(name: "Squirtle", type: .water)
    private let bulbasaur = Pokemon(name: "Bulbasaur", type: .grass)
    private let pikachu = Pokemon(name: "Pikachu", type: .electric)

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        describePokemon(pokemon: charmander)
    }

    private func describePokemon(pokemon: Pokemon) {
        switch pokemon.type {
        case .fire:
            print("\(pokemon.name) is a Fire-type Pokémon.")
        case .water:
            print("\(pokemon.name) is a Water-type Pokémon.")
        case .grass:
            print("\(pokemon.name) is a Grass-type Pokémon.")
        case .electric:
            print("\(pokemon.name) is an Electric-type Pokémon.")
        }
    }

}
