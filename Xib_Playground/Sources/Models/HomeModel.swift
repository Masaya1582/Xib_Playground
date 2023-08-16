//
//  HomeModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

struct Song {
    let title: String
}

struct Artist {
    let name: String
    let songs: [Song]
}
