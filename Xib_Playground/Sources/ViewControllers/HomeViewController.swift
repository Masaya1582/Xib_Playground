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
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var thirdTextField: UITextField!
    @IBOutlet private weak var sendCodeButton: DesignableButton!

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
    func bind(to viewModel: HomeViewModelType) {
        firstTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.textFieldInput1)
            .disposed(by: disposeBag)

        secondTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.textFieldInput2)
            .disposed(by: disposeBag)

        thirdTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.textFieldInput3)
            .disposed(by: disposeBag)

        viewModel.outputs.phoneNumber1
            .drive(firstTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.outputs.phoneNumber2
            .drive(secondTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.outputs.phoneNumber3
            .drive(thirdTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.outputs.sendCodeEnabled
            .drive(onNext: { [weak self] sendCodeEnabled in
                self?.sendCodeButton.isEnabled = sendCodeEnabled
                self?.sendCodeButton.backgroundColor = sendCodeEnabled ? .systemIndigo : .lightGray
            })
            .disposed(by: disposeBag)

        sendCodeButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                // TODO: Send Code Action
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
