//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos
import SPIndicator

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var odaiTextField: UITextField!
    @IBOutlet private weak var odaiSearchButton: UIButton!
    @IBOutlet private weak var odaiImageView: UIImageView!
    @IBOutlet private weak var odaiCommentView: UITextView!
    @IBOutlet private weak var nextOdaiButton: DesignableButton!
    @IBOutlet private weak var odaiPostButton: DesignableButton!

    private var count = 0
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
        getImages(keyword: "funny")
        bind(to: viewModel)
    }

    private func getImages(keyword: String) {
        // Pixabayに登録して個人用のAPIキーを取得する
        let url = "https://pixabay.com/api/?key=29636140-d02cd7e0dbc76d32bbc1d6324&q=\(keyword)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {
            (response) in
            switch response.result {
            case .success:
                let json: JSON = JSON(response.data as Any)
                guard let imageString = json["hits"][self.count]["webformatURL"].string else {
                    let indicatorView = SPIndicatorView(title: "エラー", message: "画像がありませんでした", preset: .error)
                    indicatorView.present(duration: 1)
                    self.odaiSearchButton.isEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.odaiSearchButton.isEnabled = true
                    }
                    return
                }
                self.odaiImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        odaiSearchButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.count = 0
                guard let odaiKeyWord = self?.odaiTextField.text else { return }
                if self?.odaiTextField.text == "" {
                    let indicatorView = SPIndicatorView(title: "エラー", message: "検索ワードを入力してください", preset: .error)
                    indicatorView.present(duration: 1)
                    self?.odaiSearchButton.isEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self?.odaiSearchButton.isEnabled = true
                    }
                } else {
                    self?.getImages(keyword: odaiKeyWord)
                }
            })
            .disposed(by: disposeBag)

        nextOdaiButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.count += 1
                guard let odaiKeyWord = self?.odaiTextField.text else { return }
                if self?.odaiTextField.text == "" {
                    self?.getImages(keyword: "funny")
                } else {
                    self?.getImages(keyword: odaiKeyWord)
                }
                self?.odaiCommentView.text = ""
            })
            .disposed(by: disposeBag)

        odaiPostButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                if self?.odaiCommentView.text == "" {
                    let indicatorView = SPIndicatorView(title: "エラー", message: "コメントを入力してください", preset: .error)
                    indicatorView.present(duration: 1)
                    self?.odaiPostButton.isEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self?.odaiPostButton.isEnabled = true
                    }
                    return
                }
                guard let odaiImage = self?.odaiImageView.image else { return }
                guard let odaiCommnet = self?.odaiCommentView.text else { return }
                let viewController = PostCompleteViewController()
                viewController.commentString = odaiCommnet
                viewController.resultImage = odaiImage
                self?.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
