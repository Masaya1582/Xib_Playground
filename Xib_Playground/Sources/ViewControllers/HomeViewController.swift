//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON
import PKHUD

class HomeViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    private var pokemonList = [Pokemon]()
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
        setupTableView()
        bind()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
    }

}

private extension HomeViewController {
    func bind() {
        searchButton.rx.tap.asSignal() // 検索ボタンを押した時
            .emit(onNext: { [weak self] in
                // テキストフィールドが空の場合
                if self?.textField.text == "" {
                    HUD.flash(.label("Please enter Pokemon name"), delay: 1.0)
                    return
                }
                DispatchQueue.main.async {
                    self?.showLoadingView()
                }
                // API通信
                guard let searchTerm = self?.textField.text?.lowercased(), let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(searchTerm)") else { return }
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            let json = try JSON(data: data)
                            let name = json["name"].stringValue
                            let stats = json["stats"].arrayValue
                            let moves = json["moves"].arrayValue
                            let statsDict = stats.reduce(into: [String: Int]()) { dict, stat in
                                dict[stat["stat"]["name"].stringValue] = stat["base_stat"].intValue
                            }
                            let movesList = moves.map { $0["move"]["name"].stringValue }
                            if let sprites = json["sprites"].dictionary,
                               let pictureUrlString = sprites["front_default"]?.stringValue,
                               let pictureUrl = URL(string: pictureUrlString),
                               let pictureData = try? Data(contentsOf: pictureUrl),
                               let picture = UIImage(data: pictureData) {
                                let pokemon = Pokemon(name: name, picture: picture, stats: statsDict, moves: movesList)
                                self?.pokemonList.append(pokemon) // ポケモンリストに追加
                                DispatchQueue.main.async {
                                    self?.tableView.reloadData()
                                    self?.hideLoadingView()
                                    self?.textField.text = ""
                                }
                            }
                        } catch {
                            print("DEBUG PRINT: \(error)")
                            DispatchQueue.main.async {
                                HUD.flash(.label("Pokemon was not found"), delay: 1.0)
                                self?.hideLoadingView()
                            }
                        }
                    }
                }
                task.resume()
            })
            .disposed(by: disposeBag)
    }

    func showLoadingView() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }

    func hideLoadingView() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        let pokemon = pokemonList[indexPath.row]
        cell.configure(with: pokemon)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
