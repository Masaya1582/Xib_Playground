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
    private let toastView = ToastView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 35))

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
        view.addSubview(toastView)
        showToast(message: "TEST TOAST")
    }

    private func showToast(message: String) {
        toastView.isHidden = false
        toastView.alpha = 0
        toastView.frame.origin.y = UIScreen.main.bounds.height

        // Set the message text
        if let label = toastView.subviews.first as? UILabel {
            label.text = message
        }

        UIView.animate(withDuration: 0.5, animations: {
            self.toastView.alpha = 1
            self.toastView.frame.origin.y -= self.toastView.frame.height
        }) { (completed) in
            if completed {
                // Hide the toast view after a certain delay (e.g., 2 seconds)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.toastView.alpha = 0
                        self.toastView.frame.origin.y = UIScreen.main.bounds.height
                    }) { (completed) in
                        if completed {
                            self.toastView.isHidden = true
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Binding
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
//        <#Button#>.rx.tap.asSignal()
//            .emit(onNext: { [weak self] in
//                <#Actions#>
//            })
//            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
