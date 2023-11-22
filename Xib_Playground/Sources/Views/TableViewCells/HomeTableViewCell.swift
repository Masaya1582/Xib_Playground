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
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    // MARK: - Setup
    func configure(with title: String) {
        titleLabel.text = title
    }
    
}
