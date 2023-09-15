//
//  Articles.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

struct Articles: Codable {
    let title: String

    init(title: String) {
        self.title = title
    }
}
