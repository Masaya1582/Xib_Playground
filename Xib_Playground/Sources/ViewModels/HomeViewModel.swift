// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol HomeViewModelInputs: AnyObject {
    var numberInput: PublishRelay<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var sum: Driver<Int> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {

    // MARK: - Input Sources
    var numberInput = PublishRelay<String>()

    // MARK: - Output Sources
    var sum: Driver<Int>

    // MARK: - Properties
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        sum = numberInput
            .map { input in
                return input
                    .components(separatedBy: ",")
                    .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
                    .reduce(0, +)
            }
            .asDriver(onErrorJustReturn: 0)
    }
}
