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
import Firebase

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = PokemonViewModel

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

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        viewModel.fetchPokemon()
            .subscribe(onNext: { pokemonList in
                print("Fetched Pokemon: \(pokemonList)")
            }, onError: { error in
                print("Error fetching Pokemon: \(error)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
