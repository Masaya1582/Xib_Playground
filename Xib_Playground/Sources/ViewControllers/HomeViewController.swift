//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    private var employeeDepartments = [
        "Alice": "HR",
        "Bob": "Finance",
        "Charlie": "Engineering",
        "Diana": "HR",
        "Eva": "Engineering"
    ]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        departmentForEmployee("Alice")
        departmentForEmployee("Charlie")
        departmentForEmployee("Anna")
    }

}

private extension HomeViewController {
    func departmentForEmployee(_ employee: String) {
        if let department = employeeDepartments[employee] {
            print("\(employee) works in the \(department) department.")
        } else {
            print("Employee not found or department information not available.")
        }
    }
}
