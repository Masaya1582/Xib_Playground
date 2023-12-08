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
    private let user1 = User(name: "Masaya", favoriteGames: ["Pokemon", "Splatoon", "Animal Crossing"])
    private let user2 = User(name: "Yuki", favoriteGames: ["Pokemon", "Splatoon", "Animal Crossing"])
    private let user3 = User(name: "Sho", favoriteGames: ["Pokemon", "Splatoon", "Animal Crossing"])
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
        let users = [user1, user2, user3]
        let allFavoriteGames = users.flatMap { $0.favoriteGames }
        print("Favorite Games: \(allFavoriteGames)")
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
        //
        //        <#TextField#>.rx.text.orEmpty
        //            .bind(to: <#ViewModel#>.inputs.<#Property#>)
        //            .disposed(by: disposeBag)
        //
        //        viewModel.outputs.<#Property#>
        //            .drive { [weak self] <#Property#> in
        //                <#Actions#>
        //            }
        //            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
