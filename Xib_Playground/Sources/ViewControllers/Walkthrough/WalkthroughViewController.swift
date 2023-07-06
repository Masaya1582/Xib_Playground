//
//  WalkthroughViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/06.
//

import UIKit
import XLPagerTabStrip
import CHIPageControl

class WalkthroughViewController: PagerTabStripViewController, PagerTabStripDataSource, PagerTabStripIsProgressiveDelegate {
    // MARK: - Dependency
    typealias Dependency = Void

    @IBOutlet private weak var pageControl: CHIPageControlAleppo!

    private lazy var menuViewControllers: [UIViewController] = {
        // FirstView
        let firstViewController = WalkthroughContentViewController(dependency: WalkthroughViewModel(image: Asset.Assets.imgApple.image, description: L10n.walkthroughText1))
        // SecondView
        let secondViewController = WalkthroughContentViewController(dependency: WalkthroughViewModel(image: Asset.Assets.imgMicrosoft.image, description: L10n.walkthroughText2))
        // ThirdView
        let thirdViewController = WalkthroughContentViewController(dependency: WalkthroughViewModel(image: Asset.Assets.imgFacebook.image, description: L10n.walkthroughText3))
        // ForthView
        let forthViewController = WalkthroughContentViewController(dependency: WalkthroughViewModel(image: Asset.Assets.imgGoogle.image, description: L10n.walkthroughText4))

        return [firstViewController, secondViewController, thirdViewController, forthViewController]
    }()

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
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return menuViewControllers
    }

    func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {}

    func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        guard fromIndex != toIndex else {
            setNeedsStatusBarAppearanceUpdate()
            return
        }
        let isForward = (fromIndex < toIndex)
        pageControl.progress = Double(fromIndex) + ((isForward) ? Double(progressPercentage) : -Double(progressPercentage))
        pageControl.progress = Double(fromIndex) + Double(isForward ? progressPercentage : -progressPercentage)
        guard indexWasChanged else { return }
        setNeedsStatusBarAppearanceUpdate()
        switch toIndex {
        case 0:
            print("DEBUG_PRINT: This is FirstView")
        case 1:
            print("DEBUG_PRINT: This is SecondView")
        case 2:
            print("DEBUG_PRINT: This is ThirdView")
        case 3:
            print("DEBUG_PRINT: This is ForthView")
        default:
            break
        }
    }

}
