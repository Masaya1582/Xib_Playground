//
//  MainViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/06.
//

import UIKit

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showWalkthroughViewController()
    }

    func showWalkthroughViewController() {
        let controller = WalkthroughViewController(dependency: ())
        insertContainerViewController(controller, to: view, at: 0)
    }

}
