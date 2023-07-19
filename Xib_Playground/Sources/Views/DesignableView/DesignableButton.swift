//
//  DesignableButton.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/07/19.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import UIKit

@IBDesignable
open class DesignableButton: UIButton {

    // MARK: - Properties
    @IBInspectable open var borderColor: UIColor = UIColor.lightGray {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet { layer.shadowOffset = shadowOffset }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet { layer.shadowColor = shadowColor.cgColor }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet { layer.shadowRadius = shadowRadius }
    }
    @IBInspectable var maskToBounds: Bool = true {
        didSet { layer.masksToBounds = maskToBounds }
    }
}
