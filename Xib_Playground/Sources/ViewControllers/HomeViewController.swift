//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import Action

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var actionButton: DesignableButton!

    private let disposeBag = DisposeBag()
    private let viewModel: Dependency
    private lazy var fetchDataAction = makeFetchDataAction()

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

    private func makeFetchDataAction() -> Action<Void, String> {
        return Action {
            // Simulate fetching data with a delay
            return Observable<String>.just("Data is fetched!")
                .delay(.seconds(2), scheduler: MainScheduler.instance)
        }
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        fetchDataAction.executing
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        fetchDataAction.elements
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)

        actionButton.rx.tap
            .bind(to: fetchDataAction.inputs)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
