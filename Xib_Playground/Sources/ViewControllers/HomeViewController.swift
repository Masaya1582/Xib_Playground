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
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var colorSlider: UISlider!

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
        let sliderValueObservable = colorSlider.rx.value

        sliderValueObservable
            .map { String(format: "%.2f", $0) }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)

        sliderValueObservable
            .map { value in
                let rotation = CGAffineTransform(rotationAngle: CGFloat(value * 2 * .pi))
                return rotation
            }
            .bind(to: colorView.rx.transform)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
