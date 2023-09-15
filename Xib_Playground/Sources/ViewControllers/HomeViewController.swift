//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import PopupDialog

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var showPopupButton: DesignableButton!

    private let disposeBag = DisposeBag()
    private let viewModel: Dependency

    // MARK: - Initialize
    init(dependency: Dependency) {
        self.viewModel = dependency
        super.init(nibName: Self.className, bundle: Self.bundle)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        showPopupButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                // ポップアップメッセージの作成
                let akazaMessage: (title: String, message: String, imageName: String) = (title: "素晴らしい提案をしよう", message: "お前も鬼にならないか？", imageName: "img_akaza")

                // ダイアログの作成
                let popup = PopupDialog(title: akazaMessage.title, message: akazaMessage.message, image: UIImage(named: akazaMessage.imageName), transitionStyle: .fadeIn)

                // 選択ボタンの作成
                let buttonOne = DefaultButton(title: "なります", dismissOnTap: true) {
                    self?.titleLabel.text = "はい、なります"
                    self?.imageView.image = UIImage(named: "img_rengoku")
                }

                // 選択ボタンの作成
                let buttonTwo = DefaultButton(title: "なりません", dismissOnTap: true) {
                    self?.titleLabel.text = "だが断る"
                    self?.imageView.image = UIImage(named: "img_kotowaru")
                }

                // 選択肢を反映させる
                popup.addButtons([buttonOne, buttonTwo])

                // ダイアログの表示
                self?.present(popup, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
