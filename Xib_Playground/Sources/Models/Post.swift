//
//  Post.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/07/05.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case userId
    }
}
