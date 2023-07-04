//
//  SwiftUIViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import SwiftUI

// Xibの場合はこっち
    struct SwiftUIViewController: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let viewController = UIViewController(nibName: "HomeViewController", bundle: nil)
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
