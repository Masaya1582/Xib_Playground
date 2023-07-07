//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var fetchImageButton: UIButton!

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
        showInitialImage()
        bind(to: viewModel)
    }

    private func showInitialImage() {
        let url = URL(string: "https://stat.ameba.jp/user_images/20140409/00/kamenrider-takarin/62/f0/j/o0350023312902837578.jpg?caw=800")
        imageView.kf.setImage(with: url)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        fetchImageButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                let url = URL(string: "https://pbs.twimg.com/profile_images/646303588617089024/ccBnONF4_400x400.jpg")
                self.imageView.kf.setImage(with: url)
                self.label.text = "ｵﾚｧ、ｸｻﾑｦﾑｯｺﾛｽ！"
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
