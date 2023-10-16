// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa
import Action

protocol HomeViewModelInputs: AnyObject {
    var idInput: PublishRelay<String> { get }
    var passwordInput: PublishRelay<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var isLoginButtonEnabled: Driver<Bool> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    // MARK: - Properties
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    // MARK: - Input Sources
    var idInput = PublishRelay<String>()
    var passwordInput = PublishRelay<String>()
    // MARK: - Output Sources
    let isLoginButtonEnabled: Driver<Bool>

    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        isLoginButtonEnabled = Observable.combineLatest(idInput, passwordInput)
            .map { id, password in
                return id.contains("@") && password.count >= 8
            }
            .asDriver(onErrorJustReturn: false)
    }

}
