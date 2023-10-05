//
//  ToastView.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/10/05.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import UIKit

class ToastView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Customize the appearance of your toast view
        self.backgroundColor = .blue
        // self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.isHidden = true

        // Add any labels, icons, or text you want to display in your toast view
        // For example, you can add a UILabel for the message text.
        let label = UILabel(frame: CGRect(x: 16, y: 8, width: frame.width - 32, height: frame.height - 16))
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0 // Allow multiple lines of text
        self.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
