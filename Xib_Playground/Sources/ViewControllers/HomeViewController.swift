//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var showSwiftUIViewButton: UIButton!

    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind() {
        showSwiftUIViewButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                let view = PopupSwiftUIView(
                    dismissAction: { [weak self] in
                        self?.dismiss(animated: true)
                    }
                )
                let hostingController = HostingController(rootView: view)
                hostingController.modalPresentationStyle = .overFullScreen
                hostingController.modalTransitionStyle = .crossDissolve
                self?.present(hostingController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
