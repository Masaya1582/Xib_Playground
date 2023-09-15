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
    @IBOutlet private weak var alertLabel: UILabel!
    @IBOutlet private weak var alertButton: DesignableButton!

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
        alertButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.showAlert()
            })
            .disposed(by: disposeBag)
    }

    func showAlert() {
        let actionAlert = UIAlertController(title: "Fish or Beef", message: "どちらかを選んでください", preferredStyle: UIAlertController.Style.actionSheet)
        let kabigonAction = UIAlertAction(title: "Fish", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            self.alertLabel.text = "Fish Please"
            print("Fishを選択")
        })
        actionAlert.addAction(kabigonAction)
        let pikachuAction = UIAlertAction(title: "Beef", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            self.alertLabel.text = "Beef Please"
            print("Beefを選択")
        })
        actionAlert.addAction(pikachuAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            self.alertLabel.text = "キャンセルしました"
            print("Cancelします")
        })
        actionAlert.addAction(cancelAction)
        self.present(actionAlert, animated: true, completion: nil)

    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
