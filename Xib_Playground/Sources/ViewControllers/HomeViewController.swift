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
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    @IBOutlet private weak var savePokemonButton: DesignableButton!

    private let userDefaults = UserDefaults.standard
    private let pokemonKey = "SavedPokemon"
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedPokemon = userDefaults.string(forKey: pokemonKey) {
            pokemonNameLabel.text = "Saved Pokemon: \(savedPokemon)"
        } else {
            pokemonNameLabel.text = "No Pokemon saved yet"
        }
    }
}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        savePokemonButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                let pokemonToSave = "Pikachu"
                self.userDefaults.set(pokemonToSave, forKey: self.pokemonKey)
                self.pokemonNameLabel.text = "Saved Pokemon: \(pokemonToSave)"
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
