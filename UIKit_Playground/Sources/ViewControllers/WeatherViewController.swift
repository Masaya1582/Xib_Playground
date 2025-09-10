//
//  WeatherViewController.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import Foundation

protocol WeatherViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showWeather(_ displayText: String)
    func showError(_ message: String)
}

final class WeatherViewController: UIViewController, WeatherViewProtocol {

    var presenter: WeatherPresenterProtocol?

    private let cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter city"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(cityTextField)
        view.addSubview(searchButton)
        view.addSubview(resultLabel)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            searchButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 10),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20)
        ])

        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
    }

    @objc private func didTapSearch() {
        if let city = cityTextField.text {
            presenter?.didTapSearch(city: city)
        }
    }

    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }

    func showWeather(_ displayText: String) {
        DispatchQueue.main.async { [weak self] in
            self?.resultLabel.text = displayText
        }

    }

    func showError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.resultLabel.text = "❌ " + message
        }
    }
}
