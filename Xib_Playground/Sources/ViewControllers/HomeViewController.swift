//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftSpinner

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var button: UIButton!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: ())
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        button.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                // フォントとサイズを指定
                SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 25.0))
                // 背景を曇らせるかどうか
                SwiftSpinner.showBlurBackground = true
                // スピナーの表示
                SwiftSpinner.show("Connecting to Database...")
                // 一定時間が経過した時に表示する
                SwiftSpinner.show(delay: 2.0, title: "It's taking longer than expected")
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    // 完了した時の処理
                    SwiftSpinner.hide(){
                        self?.label.text = "処理が完了したよ"
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
