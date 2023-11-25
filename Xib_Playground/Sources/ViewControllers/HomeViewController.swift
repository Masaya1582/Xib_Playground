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
import APIKit

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

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        let pokemonID = Int.random(in: 1...100)

        let request = GetPokemonRequest(method: .get, id: pokemonID)
        Session.shared.send(request) { result in
            switch result {
            case .success(let pokemon):
                print("Pokemon Name: \(pokemon.name)")
                print("Pokemon ID: \(pokemon.id)")

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
