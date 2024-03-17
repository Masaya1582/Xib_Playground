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

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
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
