//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class HomeViewController: UIViewController {

    private let pokedex: [String: String] = [
        "Pikachu": "An Electric-type Pokémon known for its lightning abilities.",
        "Bulbasaur": "A Grass/Poison-type Pokémon with a plant bulb on its back.",
        "Charmander": "A Fire-type Pokémon with a flame on its tail."
    ]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pikachu = pokedex["Pikachu"] else { fatalError("Pokemon not found")}
        print(pikachu)
    }
}
