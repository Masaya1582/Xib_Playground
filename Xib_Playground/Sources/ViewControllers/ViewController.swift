//
//  ViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class ViewController: UIViewController {

    private let password: String = "Password"
    private let passwordLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        passwordLabel.textAlignment = .center
        passwordLabel.text = password
        passwordLabel.sizeToFit()
        passwordLabel.center = view.center
        view.addSubview(passwordLabel)

        // detect did take screenshot
        NotificationCenter.default.addObserver(
            self, selector: #selector(captureStatusDidChange),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )

        // detect record screen
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(captureStatusDidChange),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func captureStatusDidChange() {
        if UIScreen.main.isCaptured {
            passwordLabel.text = "************"
            passwordLabel.sizeToFit()
        } else {
            passwordLabel.text = password
            passwordLabel.sizeToFit()
        }
    }

}
