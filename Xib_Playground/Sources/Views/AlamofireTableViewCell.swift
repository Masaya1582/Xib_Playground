//
//  AlamofireTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class AlamofireTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    func configure(_ title: String) {
        titleLabel.text = title
    }
    
}
