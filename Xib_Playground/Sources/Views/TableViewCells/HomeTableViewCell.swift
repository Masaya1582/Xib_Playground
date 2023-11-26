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

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }

    // MARK: - Setup
    func configure(pokemon name: String) {
        nameLabel.text = name
    }
    
}
