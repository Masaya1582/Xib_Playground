//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import APIKit

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
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
        registerNewPost()
        bind(to: viewModel)
    }

    private func registerNewPost() {
        Session.send(CreatePostRequest()) { result in
            switch result {
            case .success(let post):
                print("New Post Created")
                print("ID: \(post.id)")
                print("Title: \(post.title)")
                print("Body: \(post.body)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }
}

// MARK: - Binding
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        //        <#Button#>.rx.tap.asSignal()
        //            .emit(onNext: { [weak self] in
        //                <#Actions#>
        //            })
        //            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
