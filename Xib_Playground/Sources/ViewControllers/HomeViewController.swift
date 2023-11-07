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
    typealias Dependency = Void

    enum LoginError: Error {
        case invalidUsername
        case invalidPassword
    }

    // MARK: - Properties
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var usernameTextField: UITextField!
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

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        loginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                do {
                    try self?.performLogin()
                    self?.errorLabel.text = "Login successful!"
                    self?.errorLabel.textColor = .green
                } catch LoginError.invalidUsername {
                    self?.errorLabel.text = "Invalid username"
                    self?.errorLabel.textColor = .red
                } catch LoginError.invalidPassword {
                    self?.errorLabel.text = "Invalid password"
                    self?.errorLabel.textColor = .red
                } catch {
                    self?.errorLabel.text = "An unexpected error occurred"
                    self?.errorLabel.textColor = .red
                }
            })
            .disposed(by: disposeBag)
    }

    func performLogin() throws {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if username.isEmpty {
            throw LoginError.invalidUsername
        }
        if password.isEmpty {
            throw LoginError.invalidPassword
        }
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
