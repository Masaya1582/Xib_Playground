//
//  UILabelExtension.swift
//  UIKit_Playground
//
//  Created by Cookie-san on 2025/09/01.
//

import UIKit
import StringStylizer

extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat, maximum: CGFloat? = nil) {
        guard let text = self.text, !text.isEmpty else { return }

        let maxHeight = (maximum != nil) ? maximum : lineHeight
        let styled = text.stylize()
            .font(self.font)
            .paragraphLineHeight(maximum: maxHeight, minimum: lineHeight)
            .attr
        self.attributedText = styled
    }
}
