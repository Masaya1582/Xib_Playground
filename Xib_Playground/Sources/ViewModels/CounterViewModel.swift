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
    var counter: BehaviorRelay<Int> { get }
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
    let counter = BehaviorRelay<Int>(value: 0)

    private let disposeBag = DisposeBag()

    init() {
        // Bind input actions to counter value
        increment
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let currentValue = self.counter.value
                self.counter.accept(currentValue + 1)
            })
            .disposed(by: disposeBag)

        decrement
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let currentValue = self.counter.value
                self.counter.accept(currentValue - 1)
            })
            .disposed(by: disposeBag)

        reset
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.counter.accept(0)
            })
            .disposed(by: disposeBag)
    }
}
