//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var showSwiftUIViewButton: UIButton!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: ())
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
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
