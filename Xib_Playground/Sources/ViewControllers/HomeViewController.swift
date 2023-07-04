//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import OpenAISwift

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var questionTextField: UITextField!
    @IBOutlet private weak var askChatGPTButton: UIButton!
    @IBOutlet private weak var answerTextView: UITextView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!

    private let openAI = OpenAISwift(authToken: "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")
    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind(to: ())
    }

    // MARK: Keyboard Dismissal
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func configureView() {
        questionTextField.delegate = self
        askChatGPTButton.layer.cornerRadius = 10
        answerTextView.layer.cornerRadius = 10
        answerTextView.isEditable = false
        loadingView.isHidden = true
    }

    private func startAnimation() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }

    private func stopAnimation() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        askChatGPTButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.questionTextField.resignFirstResponder()
                self?.startAnimation()
                guard let userQuestion = self?.questionTextField.text, !userQuestion.trimmingCharacters(in: .whitespaces).isEmpty else {
                    self?.stopAnimation()
                    return
                }
                self?.answerTextView.text = "Q: \(userQuestion)"
                print("Request Sent\nQuestion: \(userQuestion)")
                self?.openAI.sendCompletion(with: userQuestion, maxTokens: 500) { [weak self] result in
                    switch result {
                    case .success(let success):
                        print("Request Successful\n-------------------------------------------------")
                        DispatchQueue.main.async {
                            self?.answerTextView.text = ("Q: \(userQuestion)\n\(success.choices?.first?.text ?? "")")
                            self?.stopAnimation()
                        }
                    case .failure(let error):
                        print("Request Failed: \(error)")
                        DispatchQueue.main.async {
                            self?.stopAnimation()
                        }
                    }
                }
                self?.questionTextField.text = ""
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
