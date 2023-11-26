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
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
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
    }

}

// MARK: - Bind
private extension HomeViewController {
    // This function binds the data fetched from the PokeAPI to the table view using RxSwift.
    func bind(to viewModel: Dependency) {
        // Guard statement to ensure the URL is valid; otherwise, the function returns early.
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }

        // Creating a URLRequest with the specified URL.
        let request = URLRequest(url: url)

        // Using RxSwift, observe URLSession.shared.rx.response to get a reactive stream of responses.
        URLSession.shared.rx.response(request: request)
        // Adding a debug print statement for the API response for debugging purposes.
            .debug("PokeAPI")
        // Mapping the raw data received from the API response to a PokemonResponse object.
            .map { _, data -> PokemonResponse in
                try JSONDecoder().decode(PokemonResponse.self, from: data)
            }
        // Using compactMap to transform the PokemonResponse to an array of Pokemon objects.
        // This filters out any nil values while mapping.
            .compactMap { $0.results }
        // Binding the array of Pokemon objects to the table view.
            .bind(to: tableView.rx.items(cellIdentifier: "HomeTableViewCell", cellType: HomeTableViewCell.self)) { index, model, cell in
                // Configuring each cell with the capitalized name of the Pokemon.
                cell.configure(pokemon: model.name.capitalized)
            }
        // Disposing the subscription by adding it to the disposeBag when the view controller is deallocated.
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
