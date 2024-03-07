//
//  ContentTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2024/03/07.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ContentTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var presidentNameLabel: UILabel!
    @IBOutlet private weak var presidentImageView: DesignableImageView!
    @IBOutlet private weak var presidentDescriptionLabel: UILabel!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        presidentImageView.image = nil
        presidentNameLabel.text = nil
        presidentDescriptionLabel.text = nil
    }

    // MARK: - Setup
    func configure(with president: President) {
        presidentImageView.image = president.image
        presidentNameLabel.text = president.name
        presidentDescriptionLabel.text = president.description
    }

}
