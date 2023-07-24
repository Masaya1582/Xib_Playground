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
    typealias Dependency = HomeViewModelType

    // MARK: - Properties
    @IBOutlet private weak var sumLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!

    private let disposeBag = DisposeBag()
    private let viewModel: Dependency

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
    func bind(to viewModel: Dependency) {
        // Bind the text field input to the viewModel's inputs
        textField.rx.text
            .orEmpty
            .bind(to: viewModel.inputs.numberInput)
            .disposed(by: disposeBag)

        // Bind the sum result to the label
        viewModel.outputs.sum
            .map { "Sum: \($0)" }
            .drive(sumLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
