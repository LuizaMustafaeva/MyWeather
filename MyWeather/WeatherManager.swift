//
//  WeatherManager.swift
//  MyWeather
//
//  Created by Luiza on 02.09.2020.
//  Copyright © 2020 Luiza. All rights reserved.
//

import Foundation
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5d49d9f75cb5e559d7ea66c5d55199c5&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                 if error != nil{
                           print(error!)
                           return
                       }
                       
                       if let safeData = data{
                        self.parseJSON(weatherData: safeData)
                           let dataString = String(data: safeData, encoding: .utf8)
                        print(dataString)
                       }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
        }catch{
            print("error")
        }
    }
    
}
