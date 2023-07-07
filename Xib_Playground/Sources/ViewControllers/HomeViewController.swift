//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    private var player = AVPlayer()
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
        playVideo()
        self.player.play()
        bind(to: viewModel)
    }

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "sample", ofType: "MOV") else { return }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.repeatCount = 0
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
            self.player.seek(to: .zero)
            self.player.play()
        }
    }

}

// MARK: - Bindings
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
