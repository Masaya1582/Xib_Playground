//
//  PokemonViewModel.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/11/17.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import Foundation
import RxSwift

final class PokemonViewModel {
    private let repository = PokemonRepository()

    func fetchPokemon() -> Observable<[Pokemon]> {
        return Observable.create { observer in
            self.repository.fetchPokemon { result in
                switch result {
                case .success(let pokemonList):
                    observer.onNext(pokemonList)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
