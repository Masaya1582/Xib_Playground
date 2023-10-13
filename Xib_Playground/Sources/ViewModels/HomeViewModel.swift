// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa
import Action

final class HomeViewModel {
    func searchData(for query: String) -> Observable<String> {
        let searchResults = [
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Fig",
            "Grapes",
            "Lemon",
            "Mango",
            "Orange",
            "Pineapple",
            "Strawberry",
            "Watermelon"
        ]
        return Observable.just(
            searchResults
                .filter{ $0.lowercased().contains(query.lowercased())}
                .joined(separator: ", ")
        )
    }
}
