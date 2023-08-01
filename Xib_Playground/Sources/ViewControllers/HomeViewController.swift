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
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var button: DesignableButton!

    private var timer: Timer!
    private var changeImageNo = 0
    private let imageNameArray = ["img_donald", "img_biden", "img_barack"]
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
        imageView.image = UIImage(named: imageNameArray[0])
        bind(to: viewModel)
    }

    private func displayImage() {
        let imageName = imageNameArray[changeImageNo]
        imageView.image = UIImage(named: imageName)
    }

    @objc func updateTimer(_ timer: Timer) {
        changeImageNo += 1
        if changeImageNo > 2 {
            changeImageNo = 0
        }
        displayImage()
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        button.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                // 停止状態なら再生できるようにする
                if self?.timer == nil {
                    self?.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self?.updateTimer(_:)), userInfo: nil, repeats: true)
                    self?.button.setTitle("ストップ", for: .normal)
                } else {
                    // 再生中なら停止できるようにする
                    self?.timer.invalidate()
                    self?.timer = nil
                    self?.button.setTitle("再生", for: .normal)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
