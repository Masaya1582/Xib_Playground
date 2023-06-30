//
//  PokemonTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
        pokemonNameLabel.text = nil
    }

    func configure(with pokemon: Pokemon) {
        pokemonImageView.image = pokemon.picture
        pokemonNameLabel.text = pokemon.name
    }
    
}
