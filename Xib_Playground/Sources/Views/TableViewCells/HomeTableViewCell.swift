//
//  HomeTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var colorView: UIView!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        colorView.backgroundColor = nil
    }

    // MARK: - Setup
    func configure(color: UIColor) {
        colorView.backgroundColor = color
    }
    
}
