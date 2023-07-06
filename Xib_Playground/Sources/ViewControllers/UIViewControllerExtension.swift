//
//  UIViewControllerExtension.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/06.
//

import UIKit

extension UIViewController {
    func insertContainerViewController(_ viewController: UIViewController?, to targetView: UIView?, at index: Int) {
        guard let targetView = targetView else { return }
        guard let viewController = viewController else { return }
        guard !children.contains(viewController) else { return }
        viewController.view.frame = targetView.bounds
        addChild(viewController)
        targetView.insertSubview(viewController.view, at: index)
        viewController.didMove(toParent: self)
        targetView.layoutIfNeeded()
    }

}
