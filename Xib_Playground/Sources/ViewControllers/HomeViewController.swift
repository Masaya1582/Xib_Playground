//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var successButton: UIButton!
    @IBOutlet private weak var errorButton: UIButton!
    @IBOutlet private weak var loadingButton: UIButton!
    @IBOutlet private weak var textButton: UIButton!

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
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        successButton.rx.tap.asSignal()
            .emit(onNext: {
                HUD.flash(.success, delay: 1.0)
            })
            .disposed(by: disposeBag)

        errorButton.rx.tap.asSignal()
            .emit(onNext: {
                HUD.flash(.error, delay: 1.0)
            })
            .disposed(by: disposeBag)

        loadingButton.rx.tap.asSignal()
            .emit(onNext: {
                HUD.flash(.progress, delay: 1.0)
            })
            .disposed(by: disposeBag)

        textButton.rx.tap.asSignal()
            .emit(onNext: {
                HUD.flash(.label("テキストメッセージを表示するよ"), delay: 1.0)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
