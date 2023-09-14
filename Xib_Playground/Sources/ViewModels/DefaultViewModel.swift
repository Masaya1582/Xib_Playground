// 
//  DefaultViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa

protocol DefaultViewModelInputs: AnyObject {

}

protocol DefaultViewModelOutputs: AnyObject {

}

protocol DefaultViewModelType: AnyObject {
    var inputs: DefaultViewModelInputs { get }
    var outputs: DefaultViewModelOutputs { get }
}

class DefaultViewModel: DefaultViewModelType, DefaultViewModelInputs, DefaultViewModelOutputs {

    // MARK: - Properties
    var inputs: DefaultViewModelInputs { return self }
    var outputs: DefaultViewModelOutputs { return self }

    // MARK: - Input Sources
    // MARK: - Output Sources

    private let disposeBag = DisposeBag()

    // MARK: - Initialization
    init() {
        
    }

}