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

    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    // MARK: - Properties
    private var _textFieldInput1 = BehaviorRelay<String>(value: "")
    private var _textFieldInput2 = BehaviorRelay<String>(value: "")
    private var _textFieldInput3 = BehaviorRelay<String>(value: "")
    private var _totalPhoneNumberInput = BehaviorRelay<Int>(value: 0)
    private var previousText1 = ""
    private var previousText2 = ""
    private var previousText3 = ""
    private static let phoneNumber1MinimumInput = 5
    private static let phoneNumber2MinimumInput = 4
    private static let phoneNumber3MinimumInput = 4
    private static let minimumPhoneNumberCount = 11
    private var _sendCodeEnabled = BehaviorRelay<Bool>(value: false)

    private let disposeBag = DisposeBag()

    init() {
        phoneNumber1 = _textFieldInput1.asDriver(onErrorDriveWith: .empty())
        phoneNumber2 = _textFieldInput2.asDriver(onErrorDriveWith: .empty())
        phoneNumber3 = _textFieldInput3.asDriver(onErrorDriveWith: .empty())

        sendCodeEnabled = _sendCodeEnabled
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)

        // 一番目のTextFieldの入力値を受け取って処理を行う
        textFieldInput1
            .map { [weak self] textFieldInput1 in
                guard let self else { return "" }
                if textFieldInput1.allSatisfy({ $0.isNumber }) && textFieldInput1.count <= HomeViewModel.phoneNumber1MinimumInput {
                    self.previousText1 = textFieldInput1
                }
                return self.previousText1
            }
            .bind(to: _textFieldInput1)
            .disposed(by: disposeBag)

        // 二番目のTextFieldの入力値を受け取って処理を行う
        textFieldInput2
            .map { [weak self] textFieldInput2 in
                guard let self else { return "" }
                if textFieldInput2.allSatisfy({ $0.isNumber }) && textFieldInput2.count <= HomeViewModel.phoneNumber2MinimumInput {
                    self.previousText2 = textFieldInput2
                }
                return self.previousText2
            }
            .bind(to: _textFieldInput2)
            .disposed(by: disposeBag)

        // 三番目のTextFieldの入力値を受け取って処理を行う
        textFieldInput3
            .map { [weak self] textFieldInput3 in
                guard let self else { return "" }
                if textFieldInput3.allSatisfy({ $0.isNumber }) && textFieldInput3.count <= HomeViewModel.phoneNumber3MinimumInput {
                    self.previousText3 = textFieldInput3
                }
                return self.previousText3
            }
            .bind(to: _textFieldInput3)
            .disposed(by: disposeBag)

        // 全てのTextFieldの入力数を合計する
        Observable.combineLatest(
            _textFieldInput1,
            _textFieldInput2,
            _textFieldInput3
        )
        .map { (textFieldInput1, textFieldInput2, textFieldInput3) in
            return textFieldInput1.count + textFieldInput2.count + textFieldInput3.count
        }
        .bind(to: _totalPhoneNumberInput)
        .disposed(by: disposeBag)

        // 合計が最低入力数より上回っていればボタンを押せるようにする
        _totalPhoneNumberInput
            .map { totalInputCount in
                return totalInputCount >= HomeViewModel.minimumPhoneNumberCount
            }
            .bind(to: _sendCodeEnabled)
            .disposed(by: disposeBag)

        sendCodeEnabled = _sendCodeEnabled
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
    }

}
