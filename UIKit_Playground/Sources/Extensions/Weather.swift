//
//  Weather.swift
//  UIKit_Playground
//
//  Created by Cookie-san on 2025/09/10.
//

import Foundation

struct Weather: Decodable {
    let cityName: String
    let temperature: Double
    let description: String

    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case main
        case weather
    }

    enum MainKeys: String, CodingKey {
        case temp
    }

    enum WeatherKeys: String, CodingKey {
        case description
    }

    // Custom init for nested JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try container.decode(String.self, forKey: .cityName)

        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try mainContainer.decode(Double.self, forKey: .temp)

        var weatherArray = try container.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try weatherArray.nestedContainer(keyedBy: WeatherKeys.self)
        description = try weatherContainer.decode(String.self, forKey: .description)
    }
}
