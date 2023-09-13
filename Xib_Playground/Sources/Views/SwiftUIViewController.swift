//
//  SwiftUIViewController.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/09/13.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
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
