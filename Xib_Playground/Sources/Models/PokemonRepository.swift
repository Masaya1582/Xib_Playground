//
//  PokemonRepository.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/11/17.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case invalidURL
    case noData
}

final class PokemonRepository {
    func fetchPokemon(completion: @escaping(Result<[Pokemon], Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let pokemonResponse = try decoder.decode(PokemonResponse.self, from: data)
                completion(.success(pokemonResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
