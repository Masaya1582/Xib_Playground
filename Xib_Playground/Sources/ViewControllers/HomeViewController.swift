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

    // MARK: - Properties
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var nameLabel: UILabel!

    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind() {
        textField.rx.text
            .orEmpty
            .bind(to: viewModel.inputs.textFieldInput)
            .disposed(by: disposeBag)

        viewModel.outputs.squareRootOfTwo
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.outputs.squareRootOfTwo
            .drive(textField.rx.text)
            .disposed(by: disposeBag)
    }
}
