//
//  WeatherInteractor.swift
//  UIKit_Playground
//
//  Created by Cookie-san on 2025/09/10.
//

import Foundation

protocol WeatherInteractorProtocol: AnyObject {
    var presenter: WeatherPresenterProtocol? { get set }
    func fetchWeather(for city: String)
}

final class WeatherInteractor: WeatherInteractorProtocol {
    weak var presenter: WeatherPresenterProtocol?
    private let apiService: WeatherAPIServiceProtocol

    init(apiService: WeatherAPIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchWeather(for city: String) {
        apiService.fetchWeather(for: city) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.presenter?.didFetchWeather(weather)
            case .failure(let error):
                self?.presenter?.didFailToFetchWeather(error)
            }
        }
    }

}
