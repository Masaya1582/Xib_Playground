//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var showHalfAlertButton: UIButton!

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

    private func showHalfAlertView() {
        // UIAlertControllerを用意する
        let actionAlert = UIAlertController(title: "Fish or Beef", message: "どちらかを選んでください", preferredStyle: UIAlertController.Style.actionSheet)

        // Fishを選択したときのアクション
        let kabigonAction = UIAlertAction(title: "Fish", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            self.label.text = "Fish Please"
            print("Fishを選択")
        })
        actionAlert.addAction(kabigonAction)

        // Beefを選択したときのアクション
        let pikachuAction = UIAlertAction(title: "Beef", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            self.label.text = "Beef Please"
            print("Beefを選択")
        })
        actionAlert.addAction(pikachuAction)

        // Cancelを選択したときのアクション
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            self.label.text = "キャンセルしました"
            print("Cancelします")
        })
        actionAlert.addAction(cancelAction)

        // アラート表示
        self.present(actionAlert, animated: true, completion: nil)

    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        showHalfAlertButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.showHalfAlertView()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
