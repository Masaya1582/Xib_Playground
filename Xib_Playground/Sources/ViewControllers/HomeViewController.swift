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

    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var incrementLabel: UIButton!
    @IBOutlet private weak var decrementLabel: UIButton!
    @IBOutlet private weak var resetLabel: UIButton!

    private let viewModel = CounterViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

private extension HomeViewController {
    func bind() {
        // Bind counter value to label
        viewModel.outputs.counter
            .map { String($0) }
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)

        // Bind increase action to increase button
        incrementLabel.rx.tap
            .bind(to: viewModel.inputs.increment)
            .disposed(by: disposeBag)

        // Bind decrease action to decrease button
        decrementLabel.rx.tap
            .bind(to: viewModel.inputs.decrement)
            .disposed(by: disposeBag)

        // Bind reset action to reset button
        resetLabel.rx.tap
            .bind(to: viewModel.inputs.reset)
            .disposed(by: disposeBag)
    }
}
