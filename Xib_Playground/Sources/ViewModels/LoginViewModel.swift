// 
//  DefaultViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol LoginViewModelInputs {
    var username: PublishRelay<String> { get }
    var password: PublishRelay<String> { get }
}

protocol LoginViewModelOutputs {
    var isLoginButtonEnabled: Observable<Bool> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs {
    // MARK: - Input Sources
    let username = PublishRelay<String>()
    let password = PublishRelay<String>()

    // MARK: - Output Sources
    let isLoginButtonEnabled: Observable<Bool>

    // MARK: - Properties
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        let usernameObservable = username.asObservable()
        let passwordObservable = password.asObservable()

        // ログインボタンのバリデーション
        isLoginButtonEnabled = Observable
            .combineLatest(usernameObservable, passwordObservable)
            .map { username, password in
                return !username.isEmpty && !password.isEmpty
            }
            .startWith(false)
            .distinctUntilChanged()
            .share()
    }
}
