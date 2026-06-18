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
    let squareView = UIView()
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
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

        // Set up the square view
        squareView.backgroundColor = .blue
        squareView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(squareView)

        // Add constraints to center the view and set initial size
        NSLayoutConstraint.activate([
            squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Store width and height constraints
        widthConstraint = squareView.widthAnchor.constraint(equalToConstant: 100)
        heightConstraint = squareView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])

        // Change the size of the square view after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.squareView.backgroundColor = .red
            self.widthConstraint.constant = 300
            self.heightConstraint.constant = 300
            self.squareView.layer.cornerRadius = 24

            // Animate the layout change
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
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

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
