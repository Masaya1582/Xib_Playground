//
//  NextViewController.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/09/15.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import UIKit

class NextViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var backButton: DesignableButton!

    public var userName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Your Name is \(userName)"
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
