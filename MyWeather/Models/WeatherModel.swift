//
//  WeatherModel.swift
//  MyWeather
//
//  Created by Luiza on 03.09.2020.
//  Copyright © 2020 Luiza. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feelsLikeTemperature: Double
    
    var temperatureString: String{
        return String(format: "%.0f", temperature)
    }
    
    var feelsLikeTemperatureString: String{
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
