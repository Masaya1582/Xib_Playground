// 
//  WalkthroughViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/06.
//

import RxSwift
import RxCocoa

protocol WalkthroughViewModelInputs: AnyObject {

}

protocol WalkthroughViewModelOutputs: AnyObject {
    var image: UIImage { get }
    var description: String { get }
}

protocol WalkthroughViewModelType: AnyObject {
    var inputs: WalkthroughViewModelInputs { get }
    var outputs: WalkthroughViewModelOutputs { get }
}

class WalkthroughViewModel: WalkthroughViewModelType, WalkthroughViewModelInputs, WalkthroughViewModelOutputs {

    var inputs: WalkthroughViewModelInputs { return self }
    var outputs: WalkthroughViewModelOutputs { return self }

    let image: UIImage
    let description: String

    private let disposeBag = DisposeBag()

    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }

}
