//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet private weak var normalProgressButton: UIButton!
    @IBOutlet private weak var textProgressButton: UIButton!
    @IBOutlet private weak var percentageProgressButton: UIButton!
    @IBOutlet private weak var popUpButton: UIButton!

    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

private extension HomeViewController {
    func bind() {
        normalProgressButton.rx.tap.asSignal()
            .emit(onNext: { _ in
                SVProgressHUD.show()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: disposeBag)

        textProgressButton.rx.tap.asSignal()
            .emit(onNext: { _ in
                SVProgressHUD.show(withStatus: "処理中です")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    SVProgressHUD.showSuccess(withStatus: "Done!")
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: disposeBag)

        percentageProgressButton.rx.tap.asSignal()
            .emit(onNext: { _ in
                SVProgressHUD.showProgress(0.4)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: disposeBag)

        popUpButton.rx.tap.asSignal()
            .emit(onNext: { _ in
                SVProgressHUD.showInfo(withStatus: "Information")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: disposeBag)
    }
}
