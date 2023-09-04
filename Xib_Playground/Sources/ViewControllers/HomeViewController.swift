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
    @IBOutlet private weak var nameTextField: UITextField!
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

    private func showAlerView() {
        let alert = UIAlertController(title: "Login", message: "Login Successful!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("【はい】が押された")
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: HomeViewModelType) {

        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.nameInput)
            .disposed(by: disposeBag)

        viewModel.outputs.loginEnabled
            .drive(onNext: { [weak self] loginEnabled in
                self?.loginButton.isEnabled = loginEnabled
                self?.loginButton.backgroundColor = loginEnabled ? .systemIndigo : .lightGray
            })
            .disposed(by: disposeBag)

        loginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.showAlerView()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
