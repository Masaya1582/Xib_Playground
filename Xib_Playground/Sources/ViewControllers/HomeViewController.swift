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

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var button: UIButton!

    private let viewModel = DefaultViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

private extension HomeViewController {
    func bind() {
        button.rx.tap
            .bind(to: viewModel.inputs.buttonTapped)
            .disposed(by: disposeBag)

        viewModel.outputs.newText
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
}
