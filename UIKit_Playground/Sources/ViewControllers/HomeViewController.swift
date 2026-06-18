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

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = HomeViewModelType

    // MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCell(HomeCollectionViewCell.self)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
            collectionView.isPagingEnabled = false
        }
    }
    private lazy var viewModel: HomeViewModelType = { fatalError("Use (dependency: ) at initialize controller") }()
    private var scrollTimer: Timer?
    private var infiniteImages: [UIImage] = []
    private let images = [
        Asset.Assets.imgPancakes.image,
        Asset.Assets.imgNuggets.image,
        Asset.Assets.imgBurger.image,
        Asset.Assets.imgSpaghetti.image,
        Asset.Assets.imgPizza.image
    ]
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
        setupInfiniteScrolling()
        startAutoScroll()
    }
}

// MARK: - Bind
extension HomeViewController {
    private func setupInfiniteScrolling() {
        guard !images.isEmpty else { return }

        // Create an extended array for infinite scrolling
        infiniteImages = images + images + images // Repeat the array three times

        // Set the initial scroll position to the middle section
        collectionView.scrollToItem(at: IndexPath(item: images.count, section: 0), at: .centeredHorizontally, animated: false)
    }

    private func adjustScrollPositionIfNeeded() {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            if visibleIndexPath.item < images.count {
                // Scroll to the middle section if at the beginning
                collectionView.scrollToItem(at: IndexPath(item: images.count + visibleIndexPath.item, section: 0), at: .centeredHorizontally, animated: false)
            } else if visibleIndexPath.item >= images.count * 2 {
                // Scroll to the middle section if at the end
                collectionView.scrollToItem(at: IndexPath(item: visibleIndexPath.item - images.count, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }

    private func startAutoScroll() {
        scrollTimer?.invalidate() // Ensure no duplicate timers
        scrollTimer = Timer.scheduledTimer(
            timeInterval: 0.02,
            target: self,
            selector: #selector(scrollCollectionView),
            userInfo: nil,
            repeats: true
        )
    }

    @objc private func scrollCollectionView() {
        let currentOffset = collectionView.contentOffset.x
        let newOffset = currentOffset + 1 // Adjust this value for speed

        // When reaching the end, reset to the first item seamlessly
        let maxOffset = collectionView.contentSize.width - collectionView.bounds.width
        if newOffset >= maxOffset {
            collectionView.contentOffset.x = 0
        } else {
            collectionView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: false)
        }
    }

    func stopAutoScroll() {
        scrollTimer?.invalidate()
        scrollTimer = nil
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        infiniteImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(HomeCollectionViewCell.self, for: indexPath)
        let images = infiniteImages[indexPath.item]
        cell.configure(with: images)
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let example = infiniteImages[indexPath.item % images.count]
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        adjustScrollPositionIfNeeded()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        adjustScrollPositionIfNeeded()
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        adjustScrollPositionIfNeeded()
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
