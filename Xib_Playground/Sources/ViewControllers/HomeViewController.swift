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

    // MARK: - Properties
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

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
        let idTextObservable = idTextField.rx.text.orEmpty.asObservable()
        let passwordTextObservable = passwordTextField.rx.text.orEmpty.asObservable()

        let loginButtonEnabledObservable = Observable.combineLatest(idTextObservable, passwordTextObservable)
            .map { id, password in
                return !id.isEmpty && !password.isEmpty
            }
            .share()

        loginButtonEnabledObservable
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        loginButtonEnabledObservable
            .map { $0 ? 1.0 : 0.3 }
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)

        loginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.handleLoginButtonTapped()
            })
            .disposed(by: disposeBag)
    }

    private func handleLoginButtonTapped() {
        let alert = UIAlertController(title: "Login Successful", message: "ログインに成功しました!", preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .default, handler: { (action) -> Void in
        })
        alert.addAction(close)
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
