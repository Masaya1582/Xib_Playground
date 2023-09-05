// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol HomeViewModelInputs: AnyObject {
    var textFieldInput1: PublishRelay<String> { get }
    var textFieldInput2: PublishRelay<String> { get }
    var textFieldInput3: PublishRelay<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var phoneNumber1: Driver<String> { get }
    var phoneNumber2: Driver<String> { get }
    var phoneNumber3: Driver<String> { get }
    var sendCodeEnabled: Driver<Bool> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {

    // MARK: - Input Sources
    var textFieldInput1 = PublishRelay<String>()
    var textFieldInput2 = PublishRelay<String>()
    var textFieldInput3 = PublishRelay<String>()
    // MARK: - Output Sources
    var phoneNumber1: Driver<String>
    var phoneNumber2: Driver<String>
    var phoneNumber3: Driver<String>
    var sendCodeEnabled: Driver<Bool>

    // MARK: - Properties
    private var _textFieldInput1 = BehaviorRelay<String>(value: "")
    private var _textFieldInput2 = BehaviorRelay<String>(value: "")
    private var _textFieldInput3 = BehaviorRelay<String>(value: "")
    private var previousText1 = ""
    private var previousText2 = ""
    private var previousText3 = ""
    private var _sendCodeEnabled = BehaviorRelay<Bool>(value: false)
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        phoneNumber1 = _textFieldInput1
            .asDriver(onErrorJustReturn: "")

        phoneNumber2 = _textFieldInput2
            .asDriver(onErrorJustReturn: "")

        phoneNumber3 = _textFieldInput3
            .asDriver(onErrorJustReturn: "")

        sendCodeEnabled = _sendCodeEnabled
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)

        textFieldInput1
            .map { [weak self] newText in
                guard let self else { return "" }
                if newText.allSatisfy({ $0.isNumber }) {
                    self.previousText1 = newText
                }
                return self.previousText1
            }
            .bind(to: _textFieldInput1)
            .disposed(by: disposeBag)

        textFieldInput2
            .map { [weak self] newText in
                guard let self else { return "" }
                if newText.allSatisfy({ $0.isNumber }) {
                    self.previousText2 = newText
                }
                return self.previousText2
            }
            .bind(to: _textFieldInput2)
            .disposed(by: disposeBag)

        textFieldInput3
            .map { [weak self] newText in
                guard let self else { return "" }
                if newText.allSatisfy({ $0.isNumber }) {
                    self.previousText3 = newText
                }
                return self.previousText3
            }
            .bind(to: _textFieldInput3)
            .disposed(by: disposeBag)
    }

}
