//
//  DesignableImageView.swift
//  common
//
//  Created by Yuya Oka on 2022/06/16.
//  Copyright © 2022 Fuller, Inc. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableImageView: UIImageView {
    // MARK: - Properties
    @IBInspectable var borderColor: UIColor = .clear {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
}
