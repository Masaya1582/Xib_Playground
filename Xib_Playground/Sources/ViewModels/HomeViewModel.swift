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
    var textFieldInput: PublishRelay<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var userInput: Driver<String> { get }
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
    var textFieldInput = PublishRelay<String>()
    // MARK: - Output Sources
    let userInput: Driver<String>

    private let _userInput = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        textFieldInput
            .bind(to: _userInput)
            .disposed(by: disposeBag)

        userInput = _userInput
            .asDriver(onErrorJustReturn: "")
    }

}
