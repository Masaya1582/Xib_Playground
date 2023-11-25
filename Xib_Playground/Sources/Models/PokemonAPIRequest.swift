//
//  PokemonAPIRequest.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/11/24.
//

import APIKit

protocol PokeAPIRequest: Request {}

extension PokeAPIRequest {
    var baseURL: URL {
        guard let url = URL(string: "https://pokeapi.co/api/v2") else {
            fatalError("Invalid URL")
        }
        return url
    }
}

struct GetPokemonRequest: PokeAPIRequest {
    typealias Response = Pokemon
    var method: APIKit.HTTPMethod
    let id: Int

    var path: String { return "/pokemon/\(id)" }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Pokemon {
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        return try JSONDecoder().decode(Pokemon.self, from: data)
    }
}
