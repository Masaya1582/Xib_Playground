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
    @IBOutlet private weak var taxIncludedLabel: UILabel!
    @IBOutlet private weak var taxExcludedLabel: UILabel!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var calculatePriceButton: UIButton!

    private var itemPrice = ItemPrice()
    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        priceTextField.keyboardType = .numberPad // 入力を数字のみに限定する
        bind(to: ())
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        calculatePriceButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let textFieldValue = self?.priceTextField.text else { return }
                guard let calculatePrice = Double(textFieldValue) else { return }
                self?.itemPrice.taxExcluded = calculatePrice // setが呼ばれる
                self?.taxIncludedLabel.text = "税込価格: \(floor(self?.itemPrice.taxIncluded ?? 0))円" //  floorを使って小数点を切り捨てる
                self?.taxExcludedLabel.text = "税抜価格: \(floor(self?.itemPrice.taxExcluded ?? 0))円" // getが呼ばれる
            })
            .disposed(by: disposeBag)
    }
}
