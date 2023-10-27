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
    var isShowIdWarning: Driver<Bool> { get }
    var isShowPasswordWarning: Driver<Bool> { get }
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
    let isShowIdWarning: Driver<Bool>
    let isShowPasswordWarning: Driver<Bool>

    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        let idWarningHiddenObservable = idInput
            .map { id in
                return id.count <= 10
            }
            .asDriver(onErrorJustReturn: false)

        let passwordWarningHiddenObservable = passwordInput
            .map { password in
                return !password.contains("@")
            }
            .asDriver(onErrorJustReturn: false)

        isShowIdWarning = idWarningHiddenObservable
        isShowPasswordWarning = passwordWarningHiddenObservable
    }

}
