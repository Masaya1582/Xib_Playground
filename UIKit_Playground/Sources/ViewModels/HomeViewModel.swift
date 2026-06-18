//
//  HomeViewModel.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Action
import RxCocoa
import RxSwift
import Foundation

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonResponse: Decodable {
    let results: [Pokemon]
}

protocol HomeViewModelInputs: AnyObject {}

protocol HomeViewModelOutputs: AnyObject {
    var items: Driver<[Pokemon]> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    // MARK: - Properties
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    // MARK: - Input Sources
    // MARK: - Output Sources
    let items: Driver<[Pokemon]>

    // MARK: - Properties
    private let loadAction: Action<Void, [Pokemon]>
    private let _items = BehaviorRelay<[Pokemon]>(value: [])
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        loadAction = Action { _ in
            return HomeViewModel.fetchPokemons()
        }
        self.items = _items.asDriver(onErrorDriveWith: .empty())
        loadAction.elements
            .bind(to: _items)
            .disposed(by: disposeBag)
        loadAction.execute(())
    }

    private static func fetchPokemons() -> Single<[Pokemon]> {
        return Single.create { single in
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100")!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                guard let data = data else {
                    single(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    let randomPokemons = Array(response.results.shuffled().prefix(30))
                    single(.success(randomPokemons))
                    print("ポケモン: \(randomPokemons)")
                } catch {
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
