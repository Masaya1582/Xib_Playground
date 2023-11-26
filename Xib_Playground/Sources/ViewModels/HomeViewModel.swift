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
    var isButtonEnabled: Driver<Bool> { get }
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
    var id = PublishRelay<String>()
    var password = PublishRelay<String>()
    // MARK: - Output Sources
    let isButtonEnabled: Driver<Bool>

    private let _isButtonEnabled = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        isButtonEnabled = _isButtonEnabled.asDriver()

        Observable.combineLatest(id, password)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .bind(to: _isButtonEnabled)
            .disposed(by: disposeBag)
    }
}
