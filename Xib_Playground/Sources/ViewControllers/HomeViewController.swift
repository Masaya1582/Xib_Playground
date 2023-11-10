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
                guard let id = self?.idTextField.text, !id.isEmpty,
                      let password = self?.passwordTextField.text, !password.isEmpty else {
                    self?.showAlert(message: "Please enter both ID and password.")
                    return
                }
                self?.loginUserToFirebase(id: id, password: password)
            })
            .disposed(by: disposeBag)
    }

    func loginUserToFirebase(id: String, password: String) {
        Auth.auth().signIn(withEmail: id, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Login failed. \(error.localizedDescription)", isSuccess: false)
            } else {
                self.showAlert(message: "Login successful!", isSuccess: true)
            }
        }
    }

    func showAlert(message: String, isSuccess: Bool = true) {
        let alert = UIAlertController(title: isSuccess ? "Success" : "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
