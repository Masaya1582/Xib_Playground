// 
//  DefaultViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol DefaultViewModelInputs: AnyObject {
    var buttonTapped: PublishRelay<Void> { get }
}

protocol DefaultViewModelOutputs: AnyObject {
    var newText: Driver<String> { get }
}

protocol DefaultViewModelType: AnyObject {
    var inputs: DefaultViewModelInputs { get }
    var outputs: DefaultViewModelOutputs { get }
}

class DefaultViewModel: DefaultViewModelType, DefaultViewModelInputs, DefaultViewModelOutputs {

    // MARK: - Properties
    var inputs: DefaultViewModelInputs { return self }
    var outputs: DefaultViewModelOutputs { return self }

    // MARK: - Input Sources
    var buttonTapped = PublishRelay<Void>()

    // MARK: - Output Sources
    var newText: Driver<String>

    private let _newText = BehaviorRelay<String>(value: "Hello India")
    private let disposeBag = DisposeBag()

    // MARK: - Initialization
    init() {
        newText = _newText.asDriver(onErrorJustReturn: "")
        buttonTapped
            .map { "Hello Japan" }
            .bind(to: _newText)
            .disposed(by: disposeBag)
    }

}
