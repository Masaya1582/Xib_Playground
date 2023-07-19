//
//  ViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class ViewController: UIViewController {

    private lazy var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        label.textAlignment = .center
        label.text = "5.0"
        label.sizeToFit()
        label.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.height / 2 - 50)
        view.addSubview(label)

        let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(stepperDidTap(stepper:)), for: .touchUpInside)
        stepper.value = 5
        stepper.minimumValue = 3
        stepper.maximumValue = 8
        stepper.center = view.center
        view.addSubview(stepper)
    }

    @objc func stepperDidTap(stepper: UIStepper) {
        label.text = "\(stepper.value)"
        label.sizeToFit()
        label.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.height / 2 - 50)
    }

}
