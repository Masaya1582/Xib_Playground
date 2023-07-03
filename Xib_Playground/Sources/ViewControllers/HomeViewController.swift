//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!

    private let decoder: JSONDecoder = JSONDecoder()
    private var articles = [Articles]()
    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getQiitaArticles()
        bind(to: ())
    }

    private func setupTableView() { // TableViewの設定
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AlamofireTableViewCell", bundle: nil), forCellReuseIdentifier: "AlamofireTableViewCell")
    }

    private func getQiitaArticles() { // Qiitaの記事を取得する
        AF.request("https://qiita.com/api/v2/items").responseDecodable(of: [Articles].self) { response in
            switch response.result {
            case .success(let articles):
                self.articles = articles
                self.tableView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {

    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlamofireTableViewCell", for: indexPath) as? AlamofireTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(articles[indexPath.row].title)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 10
    }

}
