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
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var wholeScreenshotButton: UIButton!
    @IBOutlet private weak var imageScreenshotButton: UIButton!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: ())
    }

    private func takeAllScreenShot() -> UIImage {
        let width: CGFloat = UIScreen.main.bounds.size.width
        let height: CGFloat = UIScreen.main.bounds.size.height
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let screenShotImage = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("Failed")
        }
        UIGraphicsEndImageContext()
        return screenShotImage
    }

    private func takeImageScreenShot() -> UIImage {
        let width: CGFloat = imageView.bounds.size.width
        let height: CGFloat = imageView.bounds.size.height
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
        guard let screenShotImage = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("Failed")
        }
        UIGraphicsEndImageContext()
        return screenShotImage
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        wholeScreenshotButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                let image = self?.takeAllScreenShot()
                let text = "画面全体のスクショだよ"
                let items = [text, image as Any]
                let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
                self?.present(activityVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        imageScreenshotButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                let image = self?.takeImageScreenShot()
                let text = "画像だけのスクショだよ"
                let items = [text, image as Any]
                let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
                self?.present(activityVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
