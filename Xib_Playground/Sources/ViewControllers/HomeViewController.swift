//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import Reachability

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var networkTypeLabel: UILabel!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: ())
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        do {
            let reachability = try Reachability()
            switch reachability.connection {
            case .wifi:
                networkTypeLabel.text = "Wi-Fi に接続しています"
            case .cellular:
                networkTypeLabel.text = "キャリアの回線に接続しています"
            case .unavailable:
                networkTypeLabel.text = "インターネットに接続されていません"
            case .none:
                networkTypeLabel.text = "該当なし"
            }
        } catch {
            networkTypeLabel.text = "エラーが発生しました"
        }
    }
}
