//
//  WeatherPresenter.swift
//  UIKit_Playground
//
//  Created by Cookie-san on 2025/09/10.
//

import Foundation

protocol WeatherPresenterProtocol: AnyObject {
    // Inputs
    func viewDidLoad()
    func didTapSearch(city: String)

    // Outputs
    func didFetchWeather(_ weather: Weather)
    func didFailToFetchWeather(_ error: WeatherError)
}

final class WeatherPresenter: WeatherPresenterProtocol {
    weak var view: WeatherViewProtocol?
    private let interactor: WeatherInteractorProtocol
    private let router: WeatherRouterProtocol

    init(
        view: WeatherViewProtocol,
        interactor: WeatherInteractorProtocol,
        router: WeatherRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        view?.showLoading()
        interactor.fetchWeather(for: "Tokyo")
    }

    func didTapSearch(city: String) {
        guard !city.isEmpty else {
            view?.showError("City name cannot be empty")
            return
        }

        view?.showLoading()
        interactor.fetchWeather(for: city)
    }
}

// MARK: - Outputs
extension WeatherPresenter {
    func didFetchWeather(_ weather: Weather) {
        let displayModel = "\(weather.cityName): \(weather.temperature)°C"
        view?.hideLoading()
        view?.showWeather(displayModel)
    }

    func didFailToFetchWeather(_ error: WeatherError) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}
