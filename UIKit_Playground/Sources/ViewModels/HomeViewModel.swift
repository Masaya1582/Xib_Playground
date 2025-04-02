//
//  HomeViewModel.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Action
import RxCocoa
import RxSwift
import Foundation
import UIKit

protocol HomeViewModelInputs: AnyObject {}

protocol HomeViewModelOutputs: AnyObject {
     var items: Driver<[UIImage]> { get }
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
    // MARK: - Output Sources
     let items: Driver<[UIImage]>

    // MARK: - Properties
    private let _items: BehaviorRelay<[UIImage]>
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        let images = [
            Asset.Assets.imgPancakes.image,
            Asset.Assets.imgNuggets.image,
            Asset.Assets.imgBurger.image,
            Asset.Assets.imgSpaghetti.image,
            Asset.Assets.imgPizza.image,
        ]
        self._items = BehaviorRelay(value: images)
        self.items = _items.asDriver(onErrorDriveWith: .empty())
    }
}
