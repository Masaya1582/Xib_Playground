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
    @IBOutlet private weak var colorSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var colorView: UIView!

    private let imageArray: [String] = ["highlighter", "mic.circle", "bolt.circle", "personalhotspot.circle.fill"]
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
        let selectedSegmentDriver = colorSegmentedControl.rx.selectedSegmentIndex.asDriver()

        selectedSegmentDriver
            .drive(onNext: { [weak self] selectedIndex in
                self?.updateColorView(forSegmentIndex: selectedIndex)
            })
            .disposed(by: disposeBag)

        colorSegmentedControl.setImage(UIImage(systemName: imageArray[0]), forSegmentAt: 0)
        colorSegmentedControl.setImage(UIImage(systemName: imageArray[1]), forSegmentAt: 1)
        colorSegmentedControl.setImage(UIImage(systemName: imageArray[2]), forSegmentAt: 2)
        colorSegmentedControl.setImage(UIImage(systemName: imageArray[3]), forSegmentAt: 3)
    }

    func updateColorView(forSegmentIndex index: Int) {
        switch index {
        case 0:
            colorView.backgroundColor = UIColor.brown
        case 1:
            colorView.backgroundColor = UIColor.blue
        case 2:
            colorView.backgroundColor = UIColor.green
        case 3:
            colorView.backgroundColor = UIColor.red
        default:
            colorView.backgroundColor = UIColor.black
        }
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
