//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import BLTNBoard

class HomeViewController: UIViewController {

    @IBOutlet private weak var showAnimationButton: UIButton!

    private let disposeBag = DisposeBag()

    private let boardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "俺は貴様を")
        item.actionButtonTitle = "ﾑｯｺﾛｽ"
        item.alternativeButtonTitle = "ムッコロさない"
        item.image = UIImage(named: "img_mukkorosu") // 表示したい画像(Assets.xcassetsに入れておく)
        item.actionHandler = { _ in
            HomeViewController.didTapActionButton()
        }
        item.alternativeHandler = { _ in
            HomeViewController.didTapAlternativeButton()
        }
        return BLTNItemManager(rootItem: item)
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

private extension HomeViewController {
    func bind() {
        showAnimationButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.boardManager.showBulletin(above: self)
            })
            .disposed(by: disposeBag)
    }

    // 上のボタンが押されたとき
    static func didTapActionButton() {
        print("Top Button Selected")
    }

    // 下のボタンが押されたとき
    static func didTapAlternativeButton() {
        print("Bottom Button Selected")
    }

}
