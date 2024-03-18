//
//  HomeTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var levelLabel: UILabel!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        typeLabel.text = nil
        levelLabel.text = nil
    }

    // MARK: - Setup
    func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        typeLabel.text = pokemon.type
        levelLabel.text = "Level: \(pokemon.level)"
    }
    
}
