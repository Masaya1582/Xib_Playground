//
//  CustomTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet private weak var label: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func configure(_ name: String) {
        label.text = name
    }
    
}
