//
//  UICollectionViewExtension.swift.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2024/03/17.
//  Copyright (c) 2024 ReNKCHANNEL. All rihgts reserved.
//

import UIKit

extension UICollectionView {
    // swiftlint:disable force_cast
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, identifier: String, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.className, for: indexPath)  as! T
    }
    // swiftlint:enable force_cast
}

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_: T.Type) {
        register(UINib(nibName: T.className, bundle: Bundle(for: T.self)), forCellWithReuseIdentifier: T.className)
    }

    func registerCell<T: UICollectionViewCell>(_: T.Type, identifier: String) {
        register(UINib(nibName: T.className, bundle: Bundle(for: T.self)), forCellWithReuseIdentifier: identifier)
    }

    func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind kind: String) {
        register(UINib(nibName: T.className, bundle: Bundle(for: T.self)), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.className)
    }
}

extension UICollectionView {
    func deselectAllItems(animated: Bool) {
        indexPathsForSelectedItems?.forEach { deselectItem(at: $0, animated: animated) }
    }
}
