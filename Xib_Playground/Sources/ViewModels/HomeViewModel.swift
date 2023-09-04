// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol HomeViewModelInputs: AnyObject {
    var nameInput: PublishRelay<String> { get }

}

protocol HomeViewModelOutputs: AnyObject {
    var loginEnabled: Driver<Bool> { get }

}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {

    // MARK: - Input Sources
    var nameInput = PublishRelay<String>()
    // MARK: - Output Sources
    var loginEnabled: Driver<Bool>

    // MARK: - Properties
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    private var _loginEnabled = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()

    init() {
        nameInput.asObservable()
            .map { $0.count > 8 }
            .bind(to: _loginEnabled)
            .disposed(by: disposeBag)

        loginEnabled = _loginEnabled
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
    }

}
