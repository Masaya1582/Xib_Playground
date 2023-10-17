//
//  PressAnimationButton.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class PressAnimationButton: UIButton {
    private var originalBackgroundColor: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Configure UI
    private func configureUI() {
        self.layer.cornerRadius = self.frame.height / 2
        originalBackgroundColor = self.backgroundColor
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        animateTappedState()
    }

    private func animateTappedState() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.backgroundColor = self.originalBackgroundColor?.withAlphaComponent(0.8)
        } completion: { _ in
            self.animateReleasedState()
        }
    }

    private func animateReleasedState() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut) {
            self.transform = CGAffineTransform.identity
            self.backgroundColor = self.originalBackgroundColor
        }
    }
}
