//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressField: UITextField!
    @IBOutlet private weak var addressLabel: UILabel!

    // 名前フィールドの上限文字数
    private let maxNameFieldSize = 10
    // 住所フィールドの上限文字数
    private let maxAddressFieldSize = 50

    let limitText: (Int) -> String = {
        return "あと\($0)文字"
    }
    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        bind(to: ())
    }

    // TextFieldの初期設定
    private func setupTextField() {
        nameField.addTarget(self, action: #selector(nameFieldEditingChanged(sender:)), for: .editingChanged)
        addressField.addTarget(self, action: #selector(addressFieldEditingChanged(sender:)), for: .editingChanged)
    }

    // "あと何文字"の部分をリアルタイムで検知して値を変更する
    @objc func nameFieldEditingChanged(sender: UITextField) {
        guard let changeText = sender.text else {return}
        let limitCount = maxNameFieldSize - changeText.count
        if limitCount < 1 {
            nameField.isEnabled = false
        }
        nameField.isEnabled = true
        nameLabel.text = limitText(limitCount)
    }
    // 同上
    @objc func addressFieldEditingChanged(sender: UITextField) {
        guard let changeText = sender.text else {return}
        let limitCount = maxAddressFieldSize - changeText.count
        if limitCount < 1 {
            addressField.isEnabled = false
        }
        addressField.isEnabled = true
        addressLabel.text = limitText(limitCount)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {

    }
}
