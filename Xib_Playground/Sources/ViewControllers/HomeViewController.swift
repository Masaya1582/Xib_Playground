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
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var ahoImageView: UIImageView!
    @IBOutlet private weak var incrementButton: DesignableButton!

    private var count = 0
    private var audioPlayer: AVAudioPlayer?
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
        bind(to: viewModel)
        setupAudioPlayer()
    }

    private func setupAudioPlayer() {
        guard let audioPath = Bundle.main.path(forResource: "three_aho", ofType: "mp3") else {
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error")
        }
    }

    private func playAudio() {
        audioPlayer?.play()
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        incrementButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.count += 1
                self.countLabel.text = String(self.count)
                if self.count.isMultiple(of: 3) || String(self.count).contains("3") {
                    self.ahoImageView.image = UIImage(named: "nabeatsu")
                    self.playAudio()
                } else {
                    self.ahoImageView.image = nil
                }
            })
            .disposed(by: disposeBag)
    }

}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
