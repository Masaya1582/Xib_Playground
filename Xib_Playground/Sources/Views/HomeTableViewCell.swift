//
//  HomeTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }

    func configure(_ name: String) {
        nameLabel.text = name
    }
    
}
