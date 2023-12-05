// 
//  CounterViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol CounterViewModelInputs {
    var increment: PublishRelay<Void> { get }
    var decrement: PublishRelay<Void> { get }
    var reset: PublishRelay<Void> { get }
}

protocol CounterViewModelOutputs {
    var counterValue: Driver<Int> { get }
}

protocol CounterViewModelType {
    var inputs: CounterViewModelInputs { get }
    var outputs: CounterViewModelOutputs { get }
}

class CounterViewModel: CounterViewModelType, CounterViewModelInputs, CounterViewModelOutputs {
    var inputs: CounterViewModelInputs { return self }
    var outputs: CounterViewModelOutputs { return self }

    // Inputs
    let increment = PublishRelay<Void>()
    let decrement = PublishRelay<Void>()
    let reset = PublishRelay<Void>()

    // Outputs
    let counterValue: Driver<Int>

    // Properties
    private let _counterValue = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()

    init() {
        increment
            .withLatestFrom(_counterValue)
            .map { $0 + 1 }
            .bind(to: _counterValue)
            .disposed(by: disposeBag)

        decrement
            .withLatestFrom(_counterValue)
            .map { $0 - 1 }
            .bind(to: _counterValue)
            .disposed(by: disposeBag)

        reset
            .map { 0 }
            .bind(to: _counterValue)
            .disposed(by: disposeBag)

        counterValue = _counterValue
            .asDriver(onErrorJustReturn: 0)
            .distinctUntilChanged()
    }
}
