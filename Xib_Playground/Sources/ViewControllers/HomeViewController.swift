//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var currentDateLabel: UILabel!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var currentDateButton: UIButton!
    @IBOutlet private weak var currentTimeButton: UIButton!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: ())
    }

    // 日付と曜日を取得
    private func getCurrentDate() -> String {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateStr = formatter.string(from: date as Date)
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEE", options: 0, locale: Locale.current)
        let weekStr = formatter.string(from: date as Date)
        return  dateStr + " (" + weekStr + ")"
    }

    // 現在時刻を取得
    private func getCurrentTime() -> String {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date as Date)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        currentDateButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.currentDateLabel.text = "今日は\(self.getCurrentDate())です"
            })
            .disposed(by: disposeBag)
        currentTimeButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.currentTimeLabel.text = "今は\(self.getCurrentTime())です"
            })
            .disposed(by: disposeBag)
    }
}
