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
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var idLimitLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordLimitLabel: UILabel!

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
            .bind(to: viewModel.inputs.idInput)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.passwordInput)
            .disposed(by: disposeBag)

        viewModel.outputs.isIdWarningHidden
            .drive(onNext: { [weak self] isIdWarningHidden in
                self?.idLimitLabel.isHidden = isIdWarningHidden
                if !isIdWarningHidden {
                    self?.idLimitLabel.text = "IDの上限を超えました"
                    self?.idLimitLabel.textColor = .red
                }
            })
            .disposed(by: disposeBag)

        viewModel.outputs.isPasswordWarningHidden
            .drive(onNext: { [weak self] isPasswordWarningHidden in
                self?.passwordLimitLabel.isHidden = isPasswordWarningHidden
                if !isPasswordWarningHidden {
                    self?.passwordLimitLabel.text = "使用できない文字が含まれています"
                    self?.passwordLimitLabel.textColor = .red
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
