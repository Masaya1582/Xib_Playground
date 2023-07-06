//
//  WalkthroughContentViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/06.
//

import UIKit
import XLPagerTabStrip

class WalkthroughContentViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = WalkthroughViewModelType

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bottomButton: UIButton!

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

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }


}

// MARK: - Binding
private extension WalkthroughContentViewController {
    func bind(to viewModel: WalkthroughViewModelType) {
        // 画像
        imageView.image = viewModel.outputs.image
        // 説明文
        descriptionLabel.text = viewModel.outputs.description
    }
}

extension WalkthroughContentViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: nil)
    }
}
