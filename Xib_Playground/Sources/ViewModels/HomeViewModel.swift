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
    var nameInput: PublishRelay<String> { get }
    var birthdayInput: PublishRelay<String> { get }
    var idInput: PublishRelay<String> { get }
    var passwordInput: PublishRelay<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var isOKButtonEnabled: Driver<Bool> { get }
    var progressLabel: Driver<String> { get }
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
    var nameInput = PublishRelay<String>()
    var birthdayInput = PublishRelay<String>()
    var idInput = PublishRelay<String>()
    var passwordInput = PublishRelay<String>()
    // MARK: - Output Sources
    let isOKButtonEnabled: Driver<Bool>
    let progressLabel: Driver<String>

    private let filledTextFieldsCount = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        Observable.combineLatest(nameInput, birthdayInput, idInput, passwordInput)
            .map { inputs in
                return [inputs.0, inputs.1, inputs.2, inputs.3].reduce(0) { count, input in
                    return input.isEmpty ? count : count + 1
                }
            }
            .bind(to: filledTextFieldsCount)
            .disposed(by: disposeBag)

        isOKButtonEnabled = filledTextFieldsCount.map { $0 == 4 }.asDriver(onErrorJustReturn: false)
        progressLabel = filledTextFieldsCount.map { count in
            let progress = count * 25
            return "Progress: \(progress)%"
        }
        .asDriver(onErrorJustReturn: "Progress: 0%")
    }

}
