//
//  HomeViewModel.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Action
import RxCocoa
import RxSwift

struct Pokemon {
    var name: String
    var level: Int
}

protocol HomeViewModelInputs: AnyObject {}

protocol HomeViewModelOutputs: AnyObject {
    var tableViewItems: Driver<[Pokemon]> { get }
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
    let tableViewItems: Driver<[Pokemon]>
    // MARK: - Properties
    private let _tableViewItems: BehaviorRelay<[Pokemon]>
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        let pokemon = [Pokemon(name: "Bulbasaur", level: 1),
                       Pokemon(name: "Charmander", level: 2),
                       Pokemon(name: "Bulbasaur", level: 1), Pokemon(name: "Charmander", level: 2)
        ]
        _tableViewItems = BehaviorRelay(value: pokemon)
        tableViewItems = _tableViewItems.asDriver()
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
