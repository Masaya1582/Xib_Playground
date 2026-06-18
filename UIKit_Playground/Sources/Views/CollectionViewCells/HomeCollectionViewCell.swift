//
//  HomeCollectionViewCell.swift
//  UIKit_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2024/05/10.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet private weak var infiniteImageView: UIImageView!

    // MARK: - Setup
    func configure(with image: UIImage) {
        infiniteImageView.image = image
    }
}
