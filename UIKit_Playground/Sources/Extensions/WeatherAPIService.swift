//
//  WeatherAPIService.swift
//  UIKit_Playground
//
//  Created by Cookie-san on 2025/09/10.
//

import Foundation

protocol WeatherAPIServiceProtocol {
    func fetchWeather(for city: String, completion: @escaping (Result<Weather, WeatherError>) -> Void)
}

final class WeatherAPIService: WeatherAPIServiceProtocol {
    private let apiKey = "YOUR_API_KEY" // ValidなAPIキーに置き換えてください
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"


    func fetchWeather(for city: String, completion: @escaping (Result<Weather, WeatherError>) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric") else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.networkError))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Weather.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
