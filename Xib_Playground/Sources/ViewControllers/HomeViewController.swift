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
    private let artist1 = Artist(name: "Taylor Swift", songs: [
        Song(title: "Love Story"),
        Song(title: "Shake it Off")
    ])

    private let artist2 = Artist(name: "Ed Sheeran", songs: [
        Song(title: "Shape of You"),
        Song(title: "Thinking Out Loud")
    ])

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
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        let artists = [artist1, artist2]
        let allSongs = artists.flatMap { $0.songs }

        for song in allSongs {
            print("Songs: \(song.title)")
        }
        //        <#Button#>.rx.tap.asSignal()
        //            .emit(onNext: { [weak self] in
        //                <#Actions#>
        //            })
        //            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
