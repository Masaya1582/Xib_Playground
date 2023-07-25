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
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var retryButton: DesignableButton!

    private let disposeBag = DisposeBag()
    private let viewModel: Dependency
    private var fetchDataObservable: Observable<String> {
        return Observable.create { observer in
            // Simulate a network request that sometimes fails
            let shouldFail = Bool.random()
            if shouldFail {
                observer.onError(NSError(domain: "com.app", code: 1, userInfo: nil))
            } else {
                observer.onNext("Data is fetched!")
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

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
        retryButton.rx.tap
            .flatMapLatest { [unowned self] in
                self.fetchDataObservable
                    .retry(when:) { errorObservable in
                        errorObservable.delay(.seconds(1), scheduler: MainScheduler.instance)
                    }
            }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
