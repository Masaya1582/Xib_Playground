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

    @IBOutlet private weak var collectionView: UICollectionView!

    private let bigWaveArray = ["俺は", "貴様を", "ﾑｯｺﾛｽ!"]
    private var arrayNo = 0

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }

}

extension HomeViewController: UICollectionViewDataSource {
    // セクション数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // セル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    // セルに値をセット
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(bigWaveArray[arrayNo])
        arrayNo += 1
        if arrayNo > 2 {
            arrayNo = 0
        }
        // セルに枠線をセット
        cell.layer.borderColor = UIColor.lightGray.cgColor // 外枠の色
        cell.layer.borderWidth = 1.0 // 枠線の太さ
        return cell
    }

}

// セルのサイズを調整する
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // セルサイズを指定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横方向のサイズを調整
        let cellSizeWidth: CGFloat = self.view.frame.width / 2
        let cellSizeHeight: CGFloat = self.view.frame.height / 2
        // widthとheightのサイズを返す
        return CGSize(width: cellSizeWidth, height: cellSizeHeight / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0 // 行間
    }

}
