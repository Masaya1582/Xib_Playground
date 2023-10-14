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
    @IBOutlet private weak var progressLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var okButton: DesignableButton!

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

    private func showAlertView() {
        let alert = UIAlertController(title: "Success", message: "PERFECT!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("OK Tapped")
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - Binding
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.nameInput)
            .disposed(by: disposeBag)
        birthdayTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.birthdayInput)
            .disposed(by: disposeBag)
        idTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.idInput)
            .disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.passwordInput)
            .disposed(by: disposeBag)

        viewModel.outputs.isOKButtonEnabled
            .drive(onNext: { [weak self] isOKButtonEnabled in
                self?.okButton.isEnabled = isOKButtonEnabled
                self?.okButton.backgroundColor = isOKButtonEnabled ? .systemIndigo : .lightGray
            })
            .disposed(by: disposeBag)

        viewModel.outputs.progressLabel
            .drive(onNext: { [weak self] progressText in
                self?.progressLabel.text = progressText
            })
            .disposed(by: disposeBag)

        okButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.showAlertView()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
