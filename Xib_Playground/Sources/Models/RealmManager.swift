//
//  RealmManager.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/07/18.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import RealmSwift

class RealmManager {
    private let realm: Realm

    init() {
        do {
            realm = try Realm()
        } catch let error {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }

    /// 追加
    func addTask(task: Task) {
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
            print("Failed to write to Realm: \(error)")
        }
    }

    /// 削除
    func deleteTask(task: Task) {
        do {
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("Failed to delete from Realm: \(error)")
        }
    }

    func getAllTasks() -> Results<Task> {
        return realm.objects(Task.self)
    }
}
