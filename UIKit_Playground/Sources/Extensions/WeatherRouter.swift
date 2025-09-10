//
//  WeatherRouter.swift
//  UIKit_Playground
//
//  Created by Cookie-san on 2025/09/10.
//

import UIKit

protocol WeatherRouterProtocol: AnyObject {
    func navigateToDetail(with weather: Weather)
    func dismiss()
}

final class WeatherRouter: WeatherRouterProtocol {

    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // Example: push to a detail screen
    func navigateToDetail(with weather: Weather) {
//        let detailVC = WeatherDetailViewController()
//        detailVC.view.backgroundColor = .systemBackground
//        detailVC.title = "\(weather.cityName)"
//        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }

    // Example: dismiss current screen
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
