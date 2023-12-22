// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa
import RxDataSources
import Action

protocol HomeViewModelInputs: AnyObject {
    var idInputs: PublishRelay<String> { get }
    var passwordInputs: PublishRelay<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var idWarningText: Driver<String> { get }
    var passwordWarningText: Driver<String> { get }
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
    let idInputs = PublishRelay<String>()
    let passwordInputs = PublishRelay<String>()
    // MARK: - Output Sources
    let idWarningText: Driver<String>
    let passwordWarningText: Driver<String>

    private let _idWarningText = BehaviorRelay<String>(value: "")
    private let _passwordWarningText = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        idWarningText = _idWarningText
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
        passwordWarningText = _passwordWarningText
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())

        idInputs
            .map { !$0.contains("@") && $0.count > 8 ? "正しいIDの形式を入力してください" : "" }
            .bind(to: _idWarningText)
            .disposed(by: disposeBag)
        passwordInputs
            .map { $0 != "" && $0.count < 8 ? "8文字以上入力してください" : "" }
            .bind(to: _passwordWarningText)
            .disposed(by: disposeBag)
    }
}
