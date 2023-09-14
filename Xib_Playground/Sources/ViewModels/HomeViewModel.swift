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
    var squareRootOfTwo: Driver<String> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {

    // MARK: - Input Sources
    var textFieldInput = PublishRelay<String>()
    // MARK: - Output Sources
    let squareRootOfTwo: Driver<String>

    // MARK: - Properties
    private let _squareRootOfTwo = BehaviorRelay<String>(value: "")
    private var previousInput = ""
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        squareRootOfTwo = _squareRootOfTwo.asDriver(onErrorJustReturn: "")

        textFieldInput.asObservable()
            .map { [weak self] newText in
                guard let self = self else { return "" }
                if newText.allSatisfy({ $0.isNumber }) {
                    self.previousInput = newText
                }
                return self.previousInput
            }
            .bind(to: _squareRootOfTwo)
            .disposed(by: disposeBag)
    }

}
