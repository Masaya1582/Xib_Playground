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
    // Cold Observable
    private let medowObservable = Observable<String>.create { observer in
        let pokemonArray = ["Bulbasaur", "Charmander", "Squirtle", "Pikachu"]

        for pokemon in pokemonArray {
            observer.onNext("You encountered \(pokemon)")
        }
        observer.onCompleted()
        return Disposables.create()
    }
    // Hot Observable
    private let legendaryPokemon = PublishRelay<String>()

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
        // Cold Observable
        medowObservable.subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)

        medowObservable.subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)

        // Hot Observable
        legendaryPokemon.accept("Mewtwo")
        legendaryPokemon.subscribe(onNext: { pokemon in
            print("Trainer1 encountered \(pokemon)")
        })
        .disposed(by: disposeBag)

        legendaryPokemon.accept("Zapdos")
        legendaryPokemon.subscribe(onNext: { pokemon in
            print("Trainer2 encountered \(pokemon)")
        })
        .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
