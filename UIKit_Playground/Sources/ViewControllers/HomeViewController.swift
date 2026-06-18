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
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.registerCell(HomeTableViewCell.self)
        }
    }

    private lazy var viewModel: HomeViewModelType = { fatalError("Use (dependency: ) at initialize controller") }()
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
        bind(to: viewModel)
    }
}

// MARK: - Bind
private extension HomeViewController {
    func bind(to _: Dependency) {
        viewModel.outputs.tableViewItems
            .drive(tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(HomeTableViewCell.self, for: indexPath)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
