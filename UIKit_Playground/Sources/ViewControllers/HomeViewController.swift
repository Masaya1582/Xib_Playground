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
//    @IBOutlet private weak var tableView: UITableView! {
//        didSet {
//            tableView.registerCell(HomeTableViewCell.self)
//        }
//    }
//    @IBOutlet private weak var collectionView: UICollectionView! {
//        didSet {
//            collectionView.registerCell(HomeCollectionViewCell.self)
//        }
//    }
    private lazy var viewModel: HomeViewModelType = { fatalError("Use (dependency: ) at initialize controller") }()
    private var data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = UIColor.gray // Replace with your color if needed (e.g., `Asset.Colors.gray2.color`)
        view.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return view
    }()
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
        view.backgroundColor = .white
        title = "UIRefreshControl Demo"

        // Add TableView to the View
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Attach refresh control to the TableView
        tableView.refreshControl = refreshControl
        bind(to: viewModel)
    }

    @objc private func handleRefresh() {
        print("Refreshing data...")

        // Simulate data reload (e.g., fetching new data from an API)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            // Stop the refresh animation
            self?.refreshControl.endRefreshing()

            // Update data (for demonstration purposes, shuffle data)
            self?.data.shuffle()
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Bind
private extension HomeViewController {
    func bind(to _: Dependency) {
//        <#Button#>.rx.tap.asSignal()
//            .emit(onNext: { [weak self] in
//                <#Actions#>
//            })
//            .disposed(by: disposeBag)
//
//        <#TextField#>.rx.text.orEmpty
//            .bind(to: <#ViewModel#>.inputs.<#Property#>)
//            .disposed(by: disposeBag)
//
//        viewModel.outputs.<#Property#>
//            .drive { [weak self] <#Property#> in
//                <#Actions#>
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.outputs.<#Property#>
//            .drive(<#tableView or collectionView#>.rx.items) { [weak self] <#tableView or collectionView#>, row, element in
//                let indexPath = IndexPath(row: row, section: 0)
//               let cell = <#tableView or collectionView#>.dequeueReusableCell(<#TableViewCell or CollectionViewCell#>.self, for: indexPath)
//                cell.delegate = self
//                cell.configure(with: element)
//                return cell
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.outputs.listItem
//            .drive(<#tableView or collectionView#>.rx.items) { [weak self] <#tableView or collectionView#>, row, element in
//                switch element {
//                case .<#enum Item1#>:
//                    guard let cell = <#tableView or collectionView#>.dequeueReusableCell(withIdentifier: "<#Identifier#>", for: [0, row]) as? <#TableView or CollectionView#> else {
//                        return UITableViewCell()
//                    }
//                    return cell
//                case .<#enum Item2#>(let <#property#>):
//                    guard let cell = <#tableView or collectionView#>.dequeueReusableCell(withIdentifier: "<#Identifier#>", for: [0, row]) as? <#TableView or CollectionView#> else {
//                        return UITableViewCell()
//                    }
//                    cell.delegate = self
//                    cell.configure(with: element)
//                    return cell
//                case .<#enum Item3#>:
//                    guard let cell = <#tableView or collectionView#>.dequeueReusableCell(withIdentifier: "<#Identifier#>", for: [0, row]) as? <#TableView or CollectionView#> else {
//                        return UITableViewCell()
//                    }
//                    return cell
//                }
//            }
//            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    // Add delegate methods if needed
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
