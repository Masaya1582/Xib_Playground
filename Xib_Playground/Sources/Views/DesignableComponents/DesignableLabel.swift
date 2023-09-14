//
//  DesignableLabel.swift
//  common
//
//  Created by Yuya Oka on 2022/06/10.
//  Copyright © 2022 Fuller, Inc. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableLabel: UILabel {
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
    @IBInspectable var layerShadowOffset: CGSize = .zero {
        didSet { layer.shadowOffset = layerShadowOffset }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }
    @IBInspectable var layerShadowColor: UIColor = .clear {
        didSet { layer.shadowColor = layerShadowColor.cgColor }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet { layer.shadowRadius = shadowRadius / UIScreen.main.scale }
    }
}
