//
//  WeatherError.swift
//  UIKit_Playground
//
//  Created by Cookie-san on 2025/09/10.
//

import Foundation

enum WeatherError: Error {
    case invalidURL
    case networkError
    case noData
    case decodingError
    case unknown

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
        case .networkError:
            return "Network error. Please check your connection."
        case .noData:
            return "No data received from server."
        case .decodingError:
            return "Failed to decode weather data."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
