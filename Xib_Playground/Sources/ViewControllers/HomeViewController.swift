//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    private let number = 13

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNumber()
    }

    private func checkNumber() {
        if number.isMultiple(of: 2) {
            print("numberは偶数です")
        } else {
            print("numberは奇数です")
        }
    }

}
