//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController, UIContextMenuInteractionDelegate {
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .system)
        button.setTitle("Show Context Menu", for: .normal)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 40)
        view.addSubview(button)

        // Create a UIContextMenuInteraction and set the delegate
        let contextMenuInteraction = UIContextMenuInteraction(delegate: self)
        button.addInteraction(contextMenuInteraction)
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            // Create context menu items
            let action1 = UIAction(title: "Action 1", image: UIImage(systemName: "star.fill")) { action in
                // Handle the action when selected
                // You can put your code here
            }
            let action2 = UIAction(title: "Action 2", image: UIImage(systemName: "heart.fill")) { action in
                // Handle the action when selected
                // You can put your code here
            }

            // Return a UIMenu with your actions
            return UIMenu(title: "Context Menu", children: [action1, action2])
        }
    }

}
