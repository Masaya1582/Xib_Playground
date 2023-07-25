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
    @IBOutlet private weak var startButton: DesignableButton!

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
        startButton.rx.tap
            .flatMapLatest { [unowned self] in
                self.fetchDataObservable()
                    .timeout(.seconds(2), scheduler: MainScheduler.instance)
            }
            .subscribe(onNext: { [weak self] data in
                self?.resultLabel.text = data
            }, onError: { [weak self] error in
                self?.resultLabel.text = "Task took too long!"
            })
            .disposed(by: disposeBag)
    }

    func fetchDataObservable() -> Observable<String> {
        // Simulate a time-consuming task
        return Observable<String>.create { observer in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                observer.onNext("Data is fetched!")
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
