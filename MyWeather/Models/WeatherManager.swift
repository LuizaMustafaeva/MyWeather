//
//  WeatherManager.swift
//  MyWeather
//
//  Created by Luiza on 02.09.2020.
//  Copyright © 2020 Luiza. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
     func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
           let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
           performRequest(with: urlString)
       }
    
   fileprivate func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        print("weather\(weather)")
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
   fileprivate func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let feelsLike = decodedData.main.feelsLike
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, feelsLikeTemperature: feelsLike)
            return weather
        }catch{
            print("error")
            return nil
        }
    }
    
}
