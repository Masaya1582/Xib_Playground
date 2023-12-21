// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa
import RxDataSources
import Action

protocol HomeViewModelInputs: AnyObject {
    var addressInput: PublishRelay<String> { get }
    var confirmAddressInput: PublishRelay<String> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var checkResult: Driver<String> { get }
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
    let addressInput = PublishRelay<String>()
    let confirmAddressInput = PublishRelay<String>()
    // MARK: - Output Sources
    let checkResult: Driver<String>

    private let _checkResult = BehaviorRelay<String>(value: "Enter Your Address")
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        self.checkResult = _checkResult
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())

        Observable.combineLatest(addressInput, confirmAddressInput)
            .filter { address, confirmAddress -> Bool in
                return !address.isEmpty && !confirmAddress.isEmpty
             }
            .map { address, confirmAddress -> String in
                if address == confirmAddress {
                    return "一致しています"
                } else {
                    return "一致していません"
                }
            }
            .bind(to: _checkResult)
            .disposed(by: disposeBag)
    }

}
