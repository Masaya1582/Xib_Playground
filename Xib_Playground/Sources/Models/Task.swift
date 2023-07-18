//
//  DefaultModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RealmSwift

class Task: Object {
    @objc dynamic var taskName = ""
    @objc dynamic var personName = ""
}
