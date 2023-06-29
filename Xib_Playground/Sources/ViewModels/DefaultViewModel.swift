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
    var inputs: DefaultViewModelsInputs { get }
    var outputs: DefaultViewModelsOutputs { get }
}

class DefaultViewModel: DefaultViewModelType, DefaultViewModelInputs, DefaultViewModelOutputs {

    var inputs: DefaultViewModelInputs { return self }
    var outputs: DefaultViewModelOutputs { return self }

    private let disposeBag = DisposeBag()

    init() {
        
    }

}
