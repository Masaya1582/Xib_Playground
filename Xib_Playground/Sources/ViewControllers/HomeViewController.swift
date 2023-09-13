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

    private let viewModel: CounterViewModelType = CounterViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

private extension HomeViewController {
    func bind() {
        incrementLabel.rx.tap
            .bind(to: viewModel.inputs.increment)
            .disposed(by: disposeBag)

        decrementLabel.rx.tap
            .bind(to: viewModel.inputs.decrement)
            .disposed(by: disposeBag)

        resetLabel.rx.tap
            .bind(to: viewModel.inputs.reset)
            .disposed(by: disposeBag)

        viewModel.outputs.counterValue
            .map { String($0) }
            .drive(counterLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
