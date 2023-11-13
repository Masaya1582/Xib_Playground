//
//  Pokemon.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let height: Int
    let weight: Int
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case decodingFailure
}
