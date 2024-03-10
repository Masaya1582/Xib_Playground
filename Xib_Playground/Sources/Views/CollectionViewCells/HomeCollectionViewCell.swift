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
    @IBOutlet private weak var presidentImageView: UIImageView!
    @IBOutlet private weak var presidentNameLabel: UILabel!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        presidentImageView.image = nil
        presidentNameLabel.text = nil
    }

    // MARK: - Setup
    func configure(with president: President) {
        presidentImageView.image = president.image
        presidentNameLabel.text = president.name
    }

}
