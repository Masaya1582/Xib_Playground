//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var alertViewButton: UIButton!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: ())
    }

    private func showAlerView() {
        let alert = UIAlertController(title: "Alert画面", message: "画面を閉じても良いですか？", preferredStyle: .alert)
        let delete = UIAlertAction(title: "はい", style: .default, handler: { (action) -> Void in
            // 【はい】を押したときの処理
            print("【はい】が押された")
        })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) -> Void in
            // 【キャンセル】を押したときの処理
            print("【キャンセル】が押された")
        })
        alert.addAction(delete)

        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        alertViewButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.showAlerView()
            })
            .disposed(by: disposeBag)
    }
}
