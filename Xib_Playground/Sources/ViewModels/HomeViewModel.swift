// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa
import RxDataSources
import Action

final class HomeViewModel {
    let sections: Driver<[SectionModel<String, String>]>

    init() {
        let data: [SectionModel<String, String>] = [
            SectionModel(model: "Section 1", items: ["Item 1", "Item 2", "Item 3"]),
            SectionModel(model: "Section 2", items: ["Item 4", "Item 5"]),
            SectionModel(model: "Section 3", items: ["Item 6", "Item 7", "Item 8"]),
            SectionModel(model: "Section 4", items: ["Item 9", "Item 10", "Item 11", "Item 12", "Item 13"])
        ]

        sections = Observable.just(data)
            .asDriver(onErrorJustReturn: [])
    }
}
