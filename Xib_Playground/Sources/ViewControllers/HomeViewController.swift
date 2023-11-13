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
    typealias Dependency = Void

    // MARK: - Properties
    private let pokemonCollection: [Pokemon] = [
        Pokemon(name: "Bulbasaur", evolution: "Ivysaur"),
        Pokemon(name: "Charmander", evolution: "Charmeleon"),
        Pokemon(name: "Squirtle", evolution: "Wartortle"),
        Pokemon(name: "Pikachu", evolution: nil),
        Pokemon(name: "Jigglypuff", evolution: "Wigglytuff")
    ]
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
        let pokemonObservable = Observable.from(pokemonCollection)

        // Using compactMap to filter out Pokémon without a valid evolution
        let evolvedPokemonObservable = pokemonObservable
            .compactMap { pokemon -> String? in
                return pokemon.evolution
            }

        // Subscribe to the evolved Pokémon observable
        evolvedPokemonObservable.subscribe(onNext: { evolvedPokemon in
            print("Evolved Pokémon: \(evolvedPokemon)")
        })
        .disposed(by: DisposeBag())
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
