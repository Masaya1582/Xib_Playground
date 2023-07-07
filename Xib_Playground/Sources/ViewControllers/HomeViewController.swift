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
    // MARK: - Dependency
    typealias Dependency = DefaultViewModelType

    // MARK: - Properties
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var button: UIButton!

    private let disposeBag = DisposeBag()
    private let viewModel: DefaultViewModelType

    // MARK: - Initialize
    init(dependency: Dependency) {
        self.viewModel = dependency
        super.init(nibName: Self.className, bundle: Self.bundle)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: DefaultViewModelType) {
        button.rx.tap
            .bind(to: viewModel.inputs.updateButtonTapped)
            .disposed(by: disposeBag)

        viewModel.outputs.numberText
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
