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
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    private let pokemonNameArray: [String] = ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon",
                                                     "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie",
                                                     "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill",
                                                     "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate",
                                                     "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu",
                                                     "Raichu", "Sandshrew", "Sandslash", "Nidoran♀", "Nidorina",
                                                     "Nidoqueen", "Nidoran♂", "Nidorino", "Nidoking", "Clefairy",
                                                     "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff",
                                                     "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume",
                                                     "Paras", "Parasect", "Venonat", "Venomoth", "Diglett",
                                                     "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck",
                                                     "Mankey", "Primeape", "Growlithe", "Arcanine", "Poliwag",
                                                     "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam",
                                                     "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell",
                                                     "Victreebel", "Tentacool", "Tentacruel", "Geodude", "Graveler",
                                                     "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro",
                                                     "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio",
                                                     "Seel", "Dewgong", "Grimer", "Muk", "Shellder",
                                                     "Cloyster", "Gastly", "Haunter", "Gengar", "Onix",
                                                     "Drowzee"]
    private var searchResultArray: [String] = []
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
        setupView()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchResultArray = pokemonNameArray
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }

    // セルに表示させたいものの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let pokemon = pokemonNameArray[indexPath.row]
        cell.configure(with: pokemon)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 12
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchResultArray.removeAll()
        if searchBar.text == "" {
            searchResultArray = pokemonNameArray
        } else {
            guard let searchItem = searchBar.text else { return }
            searchResultArray = pokemonNameArray.filter { pokemon in
                return pokemon.contains(searchItem)
            }
        }
        tableView.reloadData()
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
