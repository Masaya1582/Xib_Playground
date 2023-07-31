//
//  ShoppingViewController.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/07/31.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ShoppingViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: Dependency

    // MARK: - Initialize
    init(dependency: Dependency) {
        self.viewModel = dependency
        super.init(nibName: Self.className, bundle: Self.bundle)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }

}

// MARK: - Bindings
private extension ShoppingViewController {
    func bind(to viewModel: Dependency) {
        //        <#Button#>.rx.tap.asSignal()
        //            .emit(onNext: { [weak self] in
        //                <#Actions#>
        //            })
        //            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension ShoppingViewController: ViewControllerInjectable {}
