//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import UserNotifications

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var showNotificationButton: UIButton!

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

// MARK: - Binding
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        showNotificationButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.showCustomNotification()
            })
            .disposed(by: disposeBag)
    }

    func showCustomNotification() {
        OfferLocalNotificationBuilder()
            .setActions()
            .setCategory()
            .setContent()
            .build()
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
