//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import UserNotifications

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var statusButton: DesignableButton!

    private let center = UNUserNotificationCenter.current()
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
        requestAuthorization()
        bind(to: viewModel)
    }

    private func requestAuthorization() {
        // 通知を表示するための承認がまだない場合は、承認をリクエストする
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting authorization: \(error.localizedDescription)")
            } else if granted {
                // Authorizationが許可された場合
                print("Authorization granted")
            } else {
                // Authorizationが拒否された場合
                print("Authorization denied")
            }
        }
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        statusButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                self.center.getNotificationSettings { settings in
                    DispatchQueue.main.async {
                        switch settings.authorizationStatus {
                        case .authorized:
                            self.statusLabel.text = "Status: Authorized"
                        case .denied:
                            self.statusLabel.text = "Status: Denied"
                        case .notDetermined:
                            self.statusLabel.text = "Status: NotDetermined"
                        case .provisional:
                            self.statusLabel.text = "Status: Provisional"
                        case .ephemeral:
                            self.statusLabel.text = "Status: Ephemeral"
                        @unknown default:
                            fatalError("Unknown authorization status")
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
