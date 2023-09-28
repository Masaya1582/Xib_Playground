//
//  HomeTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var presidentImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        presidentImageView.image = nil
        nameLabel.text = nil
    }

    func configure(imageName: String, name: String) {
        presidentImageView.image = UIImage(named: imageName)
        nameLabel.text = name
    }
    
}
