// 
//  DefaultViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol DefaultViewModelInputs: AnyObject {
    var updateButtonTapped: PublishRelay<Void> { get }
}

protocol DefaultViewModelOutputs: AnyObject {
    var numberText: BehaviorRelay<String> { get }
}

protocol DefaultViewModelType: AnyObject {
    var inputs: DefaultViewModelInputs { get }
    var outputs: DefaultViewModelOutputs { get }
}

class DefaultViewModel: DefaultViewModelType, DefaultViewModelInputs, DefaultViewModelOutputs {

    // MARK: - Input Sources
    let updateButtonTapped = PublishRelay<Void>()

    // MARK: - Output Sources
    let numberText = BehaviorRelay<String>(value: "Tap the button")

    // MARK: - Properties
    var inputs: DefaultViewModelInputs { return self }
    var outputs: DefaultViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        updateButtonTapped
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                let randomNumber = Int.random(in: 1...100)
                self.numberText.accept("Random Number: \(randomNumber)")
            })
            .disposed(by: disposeBag)
    }

}
