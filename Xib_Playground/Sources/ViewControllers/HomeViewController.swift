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
    @IBOutlet private weak var tableView: UITableView!

    private let imageNameArray: [String] = ["img_biden", "img_donald", "img_barack", "img_george_w", "img_bill", "img_george_hw", "img_ronald", "img_jimmy", "img_gerald"]
    private let presidentNameArray: [String] = ["Joe Biden", "Donald Trump", "Barack Obama ", "George W. Bush", "Bill Clinton ", "George H.W. Bush", "Ronald Reagan", "Jimmy Carter", "Gerald Ford"]
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
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }

}

// TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    // セクション内のRowの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNameArray.count
    }

    // セルに表示させたいものの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(imageName: imageNameArray[indexPath.row], name: presidentNameArray[indexPath.row])
        return cell
    }

    // 高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8
    }

}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
