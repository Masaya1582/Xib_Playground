//
//  HomeTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var articleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        articleLabel.text = nil
    }

    func configure(_ article: String) {
        articleLabel.text = article
    }
    
}
