//
//  HomeTableViewCell.swift
//  UIKit_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2024/05/10.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var customRadiusView: UIView! {
        didSet {
            customRadiusView.layer.cornerRadius = 12
            customRadiusView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
}
