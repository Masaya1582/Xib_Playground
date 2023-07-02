//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import LTMorphingLabel

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var label: LTMorphingLabel!

    // 表示制御用タイマー
    private var timer: Timer?
    // String配列のindex用
    private var index: Int = 0
    // 表示するString配列
    private let textList = ["Let's", "Make", "History", "Today"]
    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationStyle()
        bind(to: ())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // タイマーの追加 (1.5秒ごとに表示テキストを変更する)
        timer = Timer.scheduledTimer(timeInterval: 1.5,
                                     target: self,
                                     selector: #selector(update(timer:)), userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    // アニメーションのタイプを指定
    private func setupAnimationStyle() {
        label.morphingEffect = .scale
        //        label.morphingEffect = .scale
        //        label.morphingEffect = .evaporate
        //        label.morphingEffect = .fall
        //        label.morphingEffect = .pixelate
        //        label.morphingEffect = .sparkle
        //        label.morphingEffect = .burn
        //        label.morphingEffect = .anvil
    }

    @objc func update(timer: Timer) {
        // Text表示の更新を行う
        label.text = textList[index]
        index += 1
        if index >= textList.count {
            index = 0
        }
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {

    }
}
