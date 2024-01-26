//
//  SampleModalViewController.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2024/01/25.
//  Copyright (c) 2024 ReNKCHANNEL. All rihgts reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SampleModalViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var backgroundButton: DesignableButton!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var orderButton: DesignableButton!

    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init(dependency: Dependency) {
        super.init(nibName: Self.className, bundle: Self.bundle)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

// MARK: - Bind
private extension SampleModalViewController {
    func bind() {
        Signal.merge(backgroundButton.rx.tap.asSignal(), closeButton.rx.tap.asSignal(), orderButton.rx.tap.asSignal())
            .emit(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension SampleModalViewController: ViewControllerInjectable {}
