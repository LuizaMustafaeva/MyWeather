//
//  ViewController.swift
//  MyWeather
//
//  Created by Luiza on 02.09.2020.
//  Copyright © 2020 Luiza. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.tintColor = .white
        locationButton.tintColor = .white
        
        weatherManager.delegate = self
        
        searchTextField.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
}

extension WeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName : city)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
}

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            //self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lan = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
