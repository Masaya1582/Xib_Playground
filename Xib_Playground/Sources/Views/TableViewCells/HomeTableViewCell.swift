//
//  HomeTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var menuImageView: UIImageView!
    @IBOutlet private weak var menuNameLabel: UILabel!
    @IBOutlet private weak var menuPriceLabel: UILabel!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        menuImageView.image = nil
        menuNameLabel.text = nil
        menuPriceLabel.text = nil
    }

    // MARK: - Setup
    func configure(image: UIImage, name: String, price: Double) {
        menuImageView.image = image
        menuNameLabel.text = name
        menuPriceLabel.text = "\(String(price)) $"
    }
    
}
