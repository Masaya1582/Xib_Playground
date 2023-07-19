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
    var counter: Driver<Int> { get }
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
    let counter: Driver<Int>

    private let disposeBag = DisposeBag()

    init() {
        let counterRelay = BehaviorRelay<Int>(value: 0)

        increment
            .withLatestFrom(counterRelay)
            .map { $0 + 1 }
            .bind(to: counterRelay)
            .disposed(by: disposeBag)

        decrement
            .withLatestFrom(counterRelay)
            .map { $0 - 1 }
            .bind(to: counterRelay)
            .disposed(by: disposeBag)

        reset
            .map { 0 }
            .bind(to: counterRelay)
            .disposed(by: disposeBag)

        counter = counterRelay.asDriver()
    }
}
