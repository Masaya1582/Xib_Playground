// 
//  TextFieldViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/07.
//

import RxSwift
import RxCocoa

protocol TextFieldViewModelInputs: AnyObject {
    var textFieldInput: PublishRelay<String> { get }
}

protocol TextFieldViewModelOutputs: AnyObject {
    var greetNameResult: BehaviorRelay<String> { get }
}

protocol TextFieldViewModelType: AnyObject {
    var inputs: TextFieldViewModelInputs { get }
    var outputs: TextFieldViewModelOutputs { get }
}

class TextFieldViewModel: TextFieldViewModelType, TextFieldViewModelInputs, TextFieldViewModelOutputs {

    let textFieldInput = PublishRelay<String>()
    let greetNameResult = BehaviorRelay<String>(value: "")

    var inputs: TextFieldViewModelInputs { return self }
    var outputs: TextFieldViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        textFieldInput
            .map { "Hello, \($0)!" }
            .bind(to: greetNameResult)
            .disposed(by: disposeBag)
    }

}
