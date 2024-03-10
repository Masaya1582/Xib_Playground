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
}

protocol HomeViewModelOutputs: AnyObject {
    var president: Driver<[President]> { get }
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
    let president: Driver<[President]>

    // MARK: - Properties
    private let presidentArray: [President] = [
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image),
        President(name: "Donald Trump", image: Asset.Assets.imgDonald.image)
    ]
    private let _president = BehaviorRelay<[President]>(value: [])
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        _president.accept(presidentArray)
        president = _president.asDriver(onErrorDriveWith: .empty())
    }

}
