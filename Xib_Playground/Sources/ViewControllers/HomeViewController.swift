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
    @IBOutlet private weak var selectedPickerLabel: UILabel!
    @IBOutlet private weak var countryPicker: UIPickerView!

    private let selectedValueRelay = PublishRelay<String>()
    private let countryArray: [String] = ["Japan", "France", "Germany", "Italy", "India", "United States"]

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
        countryPicker.dataSource = self
        countryPicker.delegate = self
        countryPicker.reloadAllComponents()
        bind(to: viewModel)
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        countryPicker.rx.itemSelected
            .subscribe(onNext: { [weak self] row, _ in
                guard let self else { return }
                let selectedValue = self.countryArray[row]
                self.selectedValueRelay.accept(selectedValue)
            })
            .disposed(by: disposeBag)

        selectedValueRelay
            .bind(to: selectedPickerLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArray.count
    }

    // MARK: - UIPickerViewDelegate method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArray[row]
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
