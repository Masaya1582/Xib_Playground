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
    private var imageArray: Array<UIImageView> = Array()
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
        setupAnimation()
        bind(to: viewModel)
    }

    private func setupAnimation() {
        let viewWidth: CGFloat = self.view.frame.width
        let viewHeight: CGFloat = self.view.frame.height
        // インスタンスを生成
        for i in 0..<9 {
            let imageView: UIImageView = UIImageView()
            imageView.image = Asset.Assets.imgApple.image
            imageView.contentMode = .scaleAspectFit
            imageView.frame.size = CGSize(width: 200, height: 200)
            imageArray.append(imageView)
            self.view.addSubview(imageArray[i])
        }
        // アニメーション
        // １列目
        imageArray[0].center = CGPoint(x: -viewWidth / 2, y: viewHeight * 0.6)
        imageArray[1].center = CGPoint(x: 0, y: viewHeight * 0.3)
        imageArray[2].center = CGPoint(x: viewWidth / 2, y: 0)

        // 2列目
        imageArray[3].center = CGPoint(x: -viewWidth / 2, y: viewHeight * 1.2)
        imageArray[4].center = CGPoint(x: 0, y: viewHeight * 0.9)
        imageArray[5].center = CGPoint(x: viewWidth / 2, y: viewHeight * 0.6)
        imageArray[6].center = CGPoint(x: viewWidth, y: viewHeight * 0.3)

        // ３列目
        imageArray[7].center = CGPoint(x: viewWidth / 2, y: viewHeight * 1.2)
        imageArray[8].center = CGPoint(x: viewWidth, y: viewHeight * 0.9)

        // アニメーションの設定
        // 一定の速さで繰り返しのアニメーション表示を行う
        UIView.animate(withDuration: 2, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            // １列目
            self.imageArray[0].center = CGPoint(x: 0, y: viewHeight * 0.3)
            self.imageArray[1].center = CGPoint(x: viewWidth / 2, y: 0)
            self.imageArray[2].center = CGPoint(x: viewWidth, y: -viewHeight * 0.3)

            // 2列目
            self.imageArray[3].center = CGPoint(x: 0, y: viewHeight * 0.9)
            self.imageArray[4].center = CGPoint(x: viewWidth / 2, y: viewHeight * 0.6)
            self.imageArray[5].center = CGPoint(x: viewWidth, y: viewHeight * 0.3)
            self.imageArray[6].center = CGPoint(x: viewWidth * 1.5, y: 0)

            // ３列目
            self.imageArray[7].center = CGPoint(x: viewWidth, y: viewHeight * 0.9)
            self.imageArray[8].center = CGPoint(x: viewWidth * 1.5, y: viewHeight * 0.6)
        }, completion: nil)
    }

}

// MARK: - Bind
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
