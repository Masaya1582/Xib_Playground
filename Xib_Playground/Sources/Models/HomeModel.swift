//
//  HomeModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

struct Food: Decodable {
    var name: String
    var price: String

    init(name: String, price: String) {
        self.name = name
        self.price = price
    }
}
