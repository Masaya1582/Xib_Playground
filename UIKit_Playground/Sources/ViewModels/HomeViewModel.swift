//
//  HomeViewModel.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Action
import RxCocoa
import RxSwift
import UIKit

struct Food {
    let name: String
    let image: UIImage
}

protocol HomeViewModelInputs: AnyObject {}

protocol HomeViewModelOutputs: AnyObject {
     var items: Driver<[Food]> { get }
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
    let items: Driver<[Food]>

    // MARK: - Properties
    private let _items: BehaviorRelay<[Food]>
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        let food = [Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image),
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
                    Food(name: "Pancakes", image: Asset.Assets.imgPancakes.image)]
        _items = BehaviorRelay(value: food)
        self.items = _items.asDriver(onErrorDriveWith: .empty())
    }
}

// MARK: - Item
// extension HomeViewModel {
//    enum ListItem {
//        case header
//        case shop(Content)
//        case footer
//    }
// }
