//
//  HomeViewController.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxCocoa
import RxSwift
import UIKit
import RxDataSources
import WebKit

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = HomeViewModelType

    // MARK: - Properties
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var progressView: UIProgressView!
    //    @IBOutlet private weak var tableView: UITableView! {
//        didSet {
//            tableView.registerCell(HomeTableViewCell.self)
//        }
//    }
//    @IBOutlet private weak var collectionView: UICollectionView! {
//        didSet {
//            collectionView.registerCell(HomeCollectionViewCell.self)
//        }
//    }
    private lazy var viewModel: HomeViewModelType = { fatalError("Use (dependency: ) at initialize controller") }()
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init(dependency: Dependency) {
        super.init(nibName: Self.className, bundle: Self.bundle)
        viewModel = dependency
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }
}

// MARK: - Bind
private extension HomeViewController {
    func bind(to _: Dependency) {
        // タイトル
        title = "WKWebViewサンプル"
        // WebView
        guard let url = URL(string: "https://masasophi.com/") else { return }
        webView.load(URLRequest(url: url))
        webView.rx.observeWeakly(Bool.self, #keyPath(WKWebView.isLoading))
            .compactMap { $0 }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] isLoading in
                self?.progressView.isHidden = !isLoading
            })
            .disposed(by: disposeBag)
        webView.rx.observeWeakly(Double.self, #keyPath(WKWebView.estimatedProgress))
            .compactMap { $0 }
            .map { Float($0) }
            .asDriver(onErrorDriveWith: .empty())
            .drive(progressView.rx.progress)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
