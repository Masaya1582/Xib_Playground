//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var pokemonSearchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    private let pokemonNameArray: [String] = ["ピカチュウ", "カイリュー", "フシギダネ", "ヒトカゲ", "ゼニガメ", "ミュウツー", "ミュウ", "フシギバナ", "リザードン", "カメックス", "ミュウツー", "ミュウ", "フシギバナ", "リザードン", "カメックス"]
    private var filteredPokemonArray: [String] = []
    private var isSearching: Bool {
        return !pokemonSearchBar.text!.isEmpty
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        pokemonSearchBar.delegate = self
        filteredPokemonArray = pokemonNameArray
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    // セクション内のRowの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemonArray.count
    }

    // セルに表示させたいものの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(pokemon: pokemonNameArray[indexPath.row])
        return cell
    }

    // 高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 12
    }

}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPokemonArray = pokemonNameArray
        } else {
            filteredPokemonArray = pokemonNameArray.filter{ $0.lowercased().contains(searchText.lowercased())}
        }
        tableView.reloadData()
    }
}
