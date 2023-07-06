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
    @IBOutlet private weak var modalButton: UIButton!
    @IBOutlet private weak var navigationButton: UIButton!

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
        modalButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                let nextViewController = NextViewController(nibName: "NextViewController", bundle: nil)
                self?.present(nextViewController, animated: true)
            })
            .disposed(by: disposeBag)

        navigationButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                let nextViewController = NextViewController()
                self?.navigationController?.pushViewController(nextViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
