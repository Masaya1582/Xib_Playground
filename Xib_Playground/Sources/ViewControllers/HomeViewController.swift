//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    private let pokemonList = ["Pikachu", "Bulbasaur", "Charmander", "Squirtle"]
    private let allPokemon = [
        ("Pikachu", "Electric"),
        ("Bulbasaur", "Grass"),
        ("Squirtle", "Water"),
        ("Charmander", "Fire"),
        ("Vaporeon", "Water")
    ]
    private var foundRarePokemon = false
    private var steps = 0

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        practiceForWhileWhere()
    }

    private func practiceForWhileWhere() {
        // MARK: - For文
        for pokemon in pokemonList {
            print("Your found: \(pokemon)")
        }

        // MARK: - While文
        while !foundRarePokemon {
            steps += 1
            if steps >= 1_000 {
                foundRarePokemon = true
                print("Found a rare pokemon!")
            }
        }

        // MARK: - Where文
        for (name, type) in allPokemon where type == "Water" {
            print("\(name) is a water type pokemon.")
        }
    }

}
