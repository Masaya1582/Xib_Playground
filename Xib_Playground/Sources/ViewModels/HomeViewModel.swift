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
    var idOutput: Driver<String> { get }
    var passwordOutput: Driver<String> { get }
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
    var idOutput: Driver<String>
    var passwordOutput: Driver<String>

    private let _idOutput = BehaviorRelay<String>(value: "")
    private let _passwordOutput = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        idInput
            .map { "ID: \($0)" }
            .bind(to: _idOutput)
            .disposed(by: disposeBag)

        idOutput = _idOutput
            .asDriver(onErrorJustReturn: "")

        passwordInput
            .map { "Password: \($0)" } 
            .bind(to: _passwordOutput)
            .disposed(by: disposeBag)

        passwordOutput = _passwordOutput
            .asDriver(onErrorJustReturn: "")
    }

}
