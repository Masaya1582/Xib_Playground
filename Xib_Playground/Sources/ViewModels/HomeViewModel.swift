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
    var id: PublishRelay<String> { get }
    var password: PublishRelay<String> { get }
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
    let id = PublishRelay<String>()
    let password = PublishRelay<String>()

    // MARK: - Output Sources
    let isLoginButtonEnabled: Driver<Bool>

    private let _isLoginButtonEnabled = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        self.isLoginButtonEnabled = _isLoginButtonEnabled.asDriver(onErrorJustReturn: false)

        Observable.combineLatest(id, password)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .bind(to: _isLoginButtonEnabled)
            .disposed(by: disposeBag)
    }

}
