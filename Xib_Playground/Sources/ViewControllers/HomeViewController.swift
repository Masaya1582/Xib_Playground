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
        fetchPokemon { result in
            switch result {
            case .success(let pokemon):
                print("Successfully fetched Pokémon data:")
                print("Name: \(pokemon.name)")
                print("Height: \(pokemon.height)")
                print("Weight: \(pokemon.weight)")
            case .failure(let error):
                print("Failed to fetch Pokemon data. Error: \(error)")
            }
        }
    }

}

// MARK: - Bind
private extension HomeViewController {
    func fetchPokemon(completion: @escaping (Result<Pokemon, APIError>) -> Void) {
        let apiURLString = "https://pokeapi.co/api/v2/pokemon/25"

        guard let url = URL(string: apiURLString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let pokemonData = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonData))
            } catch {
                completion(.failure(.decodingFailure))
            }
        }
        task.resume()
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
