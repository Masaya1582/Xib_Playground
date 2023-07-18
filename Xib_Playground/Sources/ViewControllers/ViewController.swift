//
//  ViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var randomLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func randomAction(_ sender: Any) {
        // ランダム値を取得するための定数を用意
        guard let randomPrefecture = PrefectureData.prefectureArray.randomElement() else { return }
        // ボタンが押された時にラベルのテキストを随時変更する
        randomLabel.text = "\(String(describing: randomPrefecture))に行こう"
    }

}
