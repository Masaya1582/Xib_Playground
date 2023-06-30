//
//  Pokemon.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation
import UIKit

class Pokemon {
    var name: String
    var picture: UIImage?
    var stats: [String: Int]
    var moves: [String]

    init(name: String, picture: UIImage?, stats: [String: Int], moves: [String]) {
        self.name = name
        self.picture = picture
        self.stats = stats
        self.moves = moves
    }
}
