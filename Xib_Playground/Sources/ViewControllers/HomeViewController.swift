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

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostsDataFromAPI()
        bind(to: ())
    }

    private func fetchPostsDataFromAPI() {
        // Create an instance of the request model
        let request = GetPostsRequest()
        // Send the API request using APIKit
        Session.send(request) { result in
            switch result {
            case .success(let posts):
                // Handle successful response
                print("Posts: \(posts)")
                // Update UI with the received data
                DispatchQueue.main.async {
                    // Update UI with posts data
                }
            case .failure(let error):
                // Handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {

    }
}
