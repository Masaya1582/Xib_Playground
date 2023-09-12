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

    private func fetchUserData() -> Observable<String> {
        return Observable.just("User Data")
    }

    private func fetchWeatherData() -> Observable<String> {
        return Observable.just("Weather Data")
    }

    private func fetchNewsData() -> Observable<String> {
        return Observable.just("News Data")
    }

    private func fetchDataFromMultipleSources() -> Observable<String> {
        return Observable.of(fetchUserData(), fetchWeatherData(), fetchNewsData())
            .flatMap { dataObservable in
                return dataObservable
            }
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        fetchDataFromMultipleSources()
            .subscribe(onNext: { data in
                print("Received data: \(data)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
