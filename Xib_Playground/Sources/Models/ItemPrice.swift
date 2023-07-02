//
//  ItemPrice.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

protocol Tax {
    var taxExcluded: Double { get set }
}

class ItemPrice: Tax { // Taxプロトコルを準拠する
    var taxIncluded: Double = 0.0 // 税込価格
    var taxExcluded: Double {
        get {
            return taxIncluded / 1.05 // 税込価格から税抜価格に戻す
        }
        set {
            self.taxIncluded = newValue * 1.05 // newValueにTextFieldの値が入ってくる
        }
    }

}
