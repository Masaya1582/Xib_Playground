// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol HomeViewModelInputs: AnyObject {
    var textFieldInput: PublishRelay<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var userName: Driver<String> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {

    // MARK: - Input Sources
    var textFieldInput = PublishRelay<String>()
    // MARK: - Output Sources
    let userName: Driver<String>

    // MARK: - Properties
    private let _userName = BehaviorRelay<String>(value: "")
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        textFieldInput
            .bind(to: _userName)
            .disposed(by: disposeBag)

        userName = _userName.asDriver(onErrorJustReturn: "")
    }

}
