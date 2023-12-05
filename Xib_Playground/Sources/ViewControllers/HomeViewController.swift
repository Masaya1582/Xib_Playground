//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var showAlertButton: DesignableButton!

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
        showAlertButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.showFishorBeefAlertView()
            })
            .disposed(by: disposeBag)
    }

    func showFishorBeefAlertView() {
        let alert = UIAlertController(title: "魚派？肉派？", message: "あなたはどっち？", preferredStyle: .alert)
        let fishAction = UIAlertAction(title: "魚派", style: .default) { _ in
            print("魚 selected")
        }
        let beefAction = UIAlertAction(title: "肉派", style: .default) { _ in
           print("肉 selected")
        }
        alert.addAction(fishAction)
        alert.addAction(beefAction)
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
