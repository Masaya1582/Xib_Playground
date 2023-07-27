//
//  PostCompleteViewController.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/07/27.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PostCompleteViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var shareButton: DesignableButton!
    @IBOutlet private weak var backToOdaiButton: DesignableButton!

    var resultImage = UIImage()
    var commentString = String()
    var screenShotImage = UIImage()
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
        configureView()
        bind(to: viewModel)
    }

    private func configureView() {
        imageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true
        self.navigationController?.isNavigationBarHidden = true
    }

    private func takeScreenShot() {
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height / 1.3)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            screenShotImage = image
        }
        UIGraphicsEndImageContext()
    }

}

// MARK: - Bindings
private extension PostCompleteViewController {
    func bind(to viewModel: Dependency) {
        shareButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.takeScreenShot()
                let items = [self?.screenShotImage] as [Any]
                let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                self?.present(activityViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        backToOdaiButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension PostCompleteViewController: ViewControllerInjectable {}
