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

    // MARK: - Properties
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var nameLabel: UILabel!

    private var previousText: String = ""
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind() {
        textField.rx.controlEvent(.editingChanged)
            .map { [weak self] in self?.textField.text ?? "" } // Get the current text
            .map { [weak self] newText in
                guard let self else { return "" }
                if newText.allSatisfy({ $0.isNumber }) {
                    // Update the previousText if the input is valid
                    self.previousText = newText
                }
                return self.previousText // Return the previous text
            }
            .bind(to: textField.rx.text) // Bind to the text field
            .disposed(by: disposeBag)

        viewModel.outputs.userName
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.outputs.userName
            .drive(textField.rx.text)
            .disposed(by: disposeBag)
    }
}
