//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController {
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
    // Called when the view controller's view has been loaded into memory.
    // Use this method to perform one-time setup tasks for the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad executed!")
    }

    // Called just before the view is about to become visible.
    // Use this method to prepare the view for appearing on the screen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear executed!")
    }

    // Called when the view has fully transitioned onto the screen and is active.
    // Use this method to start animations or initiate tasks that require the view to be visible.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear executed!")
    }

    // Called just before the view is about to disappear from the screen.
    // Use this method to perform cleanup tasks or save data before the view is removed.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear executed!")
    }

    // Called after the view has been removed from the screen.
    // Use this method to release resources or perform additional cleanup.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear executed!")
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
//        <#Button#>.rx.tap.asSignal()
//            .emit(onNext: { [weak self] in
//                <#Actions#>
//            })
//            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
