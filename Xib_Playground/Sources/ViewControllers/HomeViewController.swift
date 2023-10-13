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
    // MARK: - Dependency
    typealias Dependency = HomeViewModel

    // MARK: - Properties
    @IBOutlet private weak var searchResultLabel: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!

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
    func bind(to viewModel: HomeViewModel) {
        searchTextField.rx.text.orEmpty
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query in
                return viewModel.searchData(for: query)
                    .asDriver(onErrorJustReturn: "Error Searching")
            }
            .subscribe(onNext: { [weak self] searchResults in
                self?.searchResultLabel.text = searchResults
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
