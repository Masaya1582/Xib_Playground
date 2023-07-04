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
    private var topSafeAreaHeight: CGFloat = 0
    private var bottomSafeAreaHeight: CGFloat = 0
    private var topSafeAreaLabel: UILabel!
    private var bottomSafeAreaLabel: UILabel!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind(to: ())
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            // viewDidLayoutSubviewsでSafeAreaの取得を行う
            topSafeAreaHeight = self.view.safeAreaInsets.top
            bottomSafeAreaHeight = self.view.safeAreaInsets.bottom
            print("トップのセーフエリア: \(topSafeAreaHeight)")
            print("ボトムのセーフエリア: \(bottomSafeAreaHeight)")

            let width: CGFloat = self.view.frame.width
            let height: CGFloat = self.view.frame.height
            let labelHeight: CGFloat = 50
            topSafeAreaLabel.frame = CGRect(
                x: 0, y: topSafeAreaHeight,
                width: width, height: labelHeight)
            bottomSafeAreaLabel.frame = CGRect(
                x: 0, y: height - (labelHeight + bottomSafeAreaHeight),
                width: width, height: labelHeight)
        }
    }

    private func setupView() {
        // Top Safe Area 下のラベル
        topSafeAreaLabel = UILabel()
        topSafeAreaLabel.backgroundColor = UIColor.orange
        topSafeAreaLabel.text = "Top Safe Area"
        topSafeAreaLabel.textAlignment = NSTextAlignment.center
        topSafeAreaLabel.textColor = UIColor.white
        topSafeAreaLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(topSafeAreaLabel)

        // Bottom Safe Area 上のラベル
        bottomSafeAreaLabel = UILabel()
        bottomSafeAreaLabel.backgroundColor = UIColor.purple
        bottomSafeAreaLabel.text = "Bottom Safe Area"
        bottomSafeAreaLabel.textAlignment = NSTextAlignment.center
        bottomSafeAreaLabel.textColor = UIColor.white
        bottomSafeAreaLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(bottomSafeAreaLabel)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {

    }
}
