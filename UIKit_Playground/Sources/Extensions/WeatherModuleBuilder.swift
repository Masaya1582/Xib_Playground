//
//  WeatherModuleBuilder.swift
//  UIKit_Playground
//
//  Created by Cookie-san on 2025/09/10.
//

import UIKit

final class WeatherModuleBuilder {
    static func build() -> UIViewController {
        let viewController = WeatherViewController()
        let router = WeatherRouter(viewController: viewController)
        let apiService = WeatherAPIService()
        let interactor = WeatherInteractor(apiService: apiService)
        let presenter = WeatherPresenter(
            view: viewController,
            interactor: interactor,
            router: router
        )

        // DIを設定
        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }
}

//import UIKit
//
//final class WeatherModuleBuilder {
//    static func build() -> UIViewController {
//        // View
//        let viewController = WeatherViewController()
//
//        // Router
//        let router = WeatherRouter(viewController: viewController)
//
//        // API Service
//        let apiService = WeatherAPIService()
//
//        // Interactor
//        let interactor = WeatherInteractor(apiService: apiService)
//
//        // Presenter
//        let presenter = WeatherPresenter(
//            view: viewController,
//            interactor: interactor,
//            router: router
//        )
//
//        // DI
//        viewController.presenter = presenter
//        interactor.presenter = presenter
//
//        return viewController
//    }
//}
