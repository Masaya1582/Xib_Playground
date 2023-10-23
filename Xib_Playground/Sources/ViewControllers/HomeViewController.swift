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
    typealias Dependency = Void

    enum AlertType {
        case success
        case error(String) 
    }

    // MARK: - Properties
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: DesignableButton!

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

    private func showAlert(type: AlertType) {
        let alert: UIAlertController
        switch type {
        case .success:
            alert = UIAlertController(title: "Success", message: "ログイン成功", preferredStyle: .alert)
        case .error(let message):
            alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        }

        let close = UIAlertAction(title: "Close", style: .default, handler: { [weak self] (action) -> Void in
            self?.dismiss(animated: true)
        })
        alert.addAction(close)
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - Binding
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        loginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                if self.idTextField.text == "" || self.passwordTextField.text == "" {
                    self.showAlert(type: .error("IDとPasswordどちらも入力してください"))
                } else {
                    self.showAlert(type: .success)
                    self.idLabel.text = "ID: \(self.idTextField.text ?? "")"
                    self.passwordLabel.text = "Password: \(self.passwordTextField.text ?? "")"
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
