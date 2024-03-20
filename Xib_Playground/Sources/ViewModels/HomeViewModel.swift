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
    var food: Driver<[Food]> { get }
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
    let food: Driver<[Food]>

    // MARK: - Properties
    private let foodArray = [
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
        Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image)
    ]
    private let _food = BehaviorRelay<[Food]>(value: [])
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        _food.accept(foodArray)
        self.food = _food.asDriver(onErrorDriveWith: .empty())
    }

}

// MARK: - Item
//extension HomeViewModel {
//    enum ListItem {
//        case header
//        case shop(Content)
//        case footer
//    }
//}
