//
//  WalkthroughViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/06.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip
import CHIPageControl

class WalkthroughViewController: PagerTabStripViewController, PagerTabStripDataSource, PagerTabStripIsProgressiveDelegate {
    // MARK: - Dependency
    typealias Dependency = Void

    @IBOutlet private weak var pageControl: CHIPageControlAleppo!
    @IBOutlet private weak var bottomButton: UIButton!

    private lazy var slideViewControllers: [UIViewController] = {
        let firstViewController = WalkthroughContentViewController(dependency: WalkthroughViewModel(image: Asset.Assets.imgGoogle.image, description: L10n.walkthroughGoogle))
        let secondViewController = WalkthroughContentViewController(dependency: WalkthroughViewModel(image: Asset.Assets.imgApple.image, description: L10n.walkthroughApple))
        let thirdViewController = WalkthroughContentViewController(dependency: WalkthroughViewModel(image: Asset.Assets.imgFacebook.image, description: L10n.walkthroughFacebook))
        let forthViewController = WalkthroughContentViewController(dependency: WalkthroughViewModel(image: Asset.Assets.imgAmazon.image, description: L10n.walkthroughAmazon))

        return [firstViewController, secondViewController, thirdViewController, forthViewController]
    }()

    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init(dependency: Dependency) {
        super.init(nibName: Self.className, bundle: Self.bundle)
        delegate = self
        datasource = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        containerView.contentInsetAdjustmentBehavior = .never
        super.viewDidLoad()
        containerView.bounces = false
        containerView.alwaysBounceHorizontal = false
        bind()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return slideViewControllers
    }

    func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {}

    func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        configureButtonDesign(for: slideViewControllers.endIndex - 1, progressPercentage: progressPercentage, toIndex: toIndex)
        guard fromIndex != toIndex else { return }
        let isForward = (fromIndex < toIndex)
        pageControl.progress = Double(fromIndex) + Double(isForward ? progressPercentage : -progressPercentage)
    }

}

private extension WalkthroughViewController {
    func bind() {
        bottomButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.defaultOrProductImageSwipeTapped()
            })
            .disposed(by: disposeBag)
    }

    func defaultOrProductImageSwipeTapped() {
        if currentIndex == slideViewControllers.endIndex - 1 {
            print("This is end of Walkthrough!")
        } else {
            moveToViewController(at: currentIndex + 1)
        }
    }
}

private extension WalkthroughViewController {
    func configureButtonDesign(for lastPageIndex: Int, progressPercentage: CGFloat, toIndex: Int) {
        let title: String
        let backgroundColor: UIColor
        let titleColor: UIColor
        if progressPercentage >= 1.0 && toIndex == lastPageIndex {
            title = "会員登録して始める"
            backgroundColor = Asset.Colors.mainColor.color
            titleColor = .black
        } else {
            title = "次へ"
            backgroundColor = Asset.Colors.bakcgroundColor.color
            titleColor = .black
        }
        bottomButton.setTitle(title, for: .normal)
        bottomButton.backgroundColor = backgroundColor
        bottomButton.setTitleColor(titleColor, for: .normal)
    }
}
