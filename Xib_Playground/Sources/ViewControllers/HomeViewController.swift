//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        }
    }

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
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
//        <#Button#>.rx.tap.asSignal()
//            .emit(onNext: { [weak self] in
//                <#Actions#>
//            })
//            .disposed(by: disposeBag)
//
//        <#TextField#>.rx.text.orEmpty
//            .bind(to: <#ViewModel#>.inputs.<#Property#>)
//            .disposed(by: disposeBag)
//
//        viewModel.outputs.<#Property#>
//            .drive { [weak self] <#Property#> in
//                <#Actions#>
//            }
//            .disposed(by: disposeBag)
    }
}

// MARK: - Extensions
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // セクション数
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return <#返したい数#>
//    }

    // セル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    // セルに値をセット
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // widthReuseIdentifierにはStoryboardで設定したセルのIDを指定
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
//        // セルに枠線をセット
//        cell.layer.borderColor = UIColor.<#つけたい色#>.cgColor // 外枠の色
//        cell.layer.borderWidth = <#太さ#> // 枠線の太さ
        return cell
    }

}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
