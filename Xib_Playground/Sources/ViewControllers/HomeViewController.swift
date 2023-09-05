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

    private func showAlerView() {
        let alert = UIAlertController(title: "Success", message: "Your PhoneNumber was sent successfully!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("OK Tapped")
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: HomeViewModelType) {
        // 一番目のTextFieldの入力値をViewModelに流す
        firstTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.textFieldInput1)
            .disposed(by: disposeBag)

        // 二番目のTextFieldの入力値をViewModelに流す
        secondTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.textFieldInput2)
            .disposed(by: disposeBag)

        // 三番目のTextFieldの入力値をViewModelに流す
        thirdTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.textFieldInput3)
            .disposed(by: disposeBag)

        // ViewModelで処理された一番目の入力値をTextFieldに返す
        viewModel.outputs.phoneNumber1
            .drive(firstTextField.rx.text)
            .disposed(by: disposeBag)

        // ViewModelで処理された二番目の入力値をTextFieldに返す
        viewModel.outputs.phoneNumber2
            .drive(secondTextField.rx.text)
            .disposed(by: disposeBag)

        // ViewModelで処理された三番目の入力値をTextFieldに返す
        viewModel.outputs.phoneNumber3
            .drive(thirdTextField.rx.text)
            .disposed(by: disposeBag)

        // ボタンの押せる/押せないを制御する(合わせて色も変える)
        viewModel.outputs.sendCodeEnabled
            .drive(onNext: { [weak self] sendCodeEnabled in
                self?.sendCodeButton.isEnabled = sendCodeEnabled
                self?.sendCodeButton.backgroundColor = sendCodeEnabled ? .systemIndigo : .lightGray
            })
            .disposed(by: disposeBag)

        // ボタンがタップされた時にAlertViewを表示する
        sendCodeButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.showAlerView()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
