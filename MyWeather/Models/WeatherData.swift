//
//  WeatherData.swift
//  MyWeather
//
//  Created by Luiza on 02.09.2020.
//  Copyright © 2020 Luiza. All rights reserved.
//

import Foundation
struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey{
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let description: String
    let id: Int
}
