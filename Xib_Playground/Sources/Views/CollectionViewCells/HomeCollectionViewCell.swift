//
//  HomeCollectionViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        foodImageView.image = nil
        foodNameLabel.text = nil
    }

    // MARK: - Setup
    func configure(with food: Food) {
        foodImageView.image = food.image
        foodNameLabel.text = food.name
    }

}
