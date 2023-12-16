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

final class HomeViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
            tableView.tableFooterView = UIView()
            tableView.rx.setDelegate(self).disposed(by: disposeBag)
        }
    }

    private let foodNameArray: [String] = ["Burger", "Nuggets", "Pancakes", "Pizza", "Spaghetti"]
    private let foodImageArray: [UIImage] = [Asset.Assets.imgBurger.image, Asset.Assets.imgNuggets.image, Asset.Assets.imgPancakes.image, Asset.Assets.imgPizza.image, Asset.Assets.imgSpaghetti.image]
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
    func bind(to viewModel: Dependency) {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
            configureCell: { _, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(imageName: self.foodImageArray[indexPath.row], foodName: item)
                return cell
            })

        // Convert foodNameArray to items for the table view
        let items = foodNameArray.map { name in
            return SectionModel(model: "Food", items: [name])
        }

        Observable.just(items)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
