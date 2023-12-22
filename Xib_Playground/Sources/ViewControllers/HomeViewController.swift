//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = HomeViewModelType

    // MARK: - Properties
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var idWarningLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordWarningLabel: UILabel!

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

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        idTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.idInputs)
            .disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.passwordInputs)
            .disposed(by: disposeBag)

        viewModel.outputs.idWarningText
            .drive(idWarningLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.outputs.passwordWarningText
            .drive(passwordWarningLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
