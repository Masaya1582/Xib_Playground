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
import Firebase

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signupButton: DesignableButton!

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
        signupButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let id = self?.idTextField.text, !id.isEmpty,
                      let password = self?.passwordTextField.text, !password.isEmpty else {
                    self?.showAlert(message: "Please enter both ID and password.")
                    return
                }
                self?.registerUserToFirebase(id: id, password: password)
            })
            .disposed(by: disposeBag)
    }

    func registerUserToFirebase(id: String, password: String) {
        Auth.auth().createUser(withEmail: id, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Registration failed")
                print("Error Details: \(error.localizedDescription)")
            } else {
                self.showAlert(message: "Registration successful!")
            }
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
