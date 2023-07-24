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
    var buttonTapped: PublishRelay<Void> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var latestText: Driver<String> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {

    // MARK: - Input Sources
    var textFieldInput = PublishRelay<String>()
    var buttonTapped = PublishRelay<Void>()

    // MARK: - Output Sources
    var latestText: Driver<String>

    // MARK: - Properties
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        latestText = buttonTapped
            .withLatestFrom(textFieldInput.asObservable())
            .asDriver(onErrorJustReturn: "")
    }
}
