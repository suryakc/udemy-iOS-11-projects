//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "4cc790c97b3555141108ee769c0510fe"
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    var weatherData = WeatherDataModel()


    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getWeatherData(url: String, params: [String : String]) {
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                print("Got weather data...")
                let weatherDataJSON : JSON = JSON (response.result.value!)
                //print(weatherDataJSON)
                self.updateWeatherData(json: weatherDataJSON)
            } else {
                print("An error occurred when calling weather api. Error: \(response.result.error)")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    func updateWeatherData(json : JSON) {
        let code = json["cod"].intValue
        if code == 200 { // Success
            let temperature = json["main"]["temp"].doubleValue
            weatherData.temperature = Int(temperature - 273.15) // Convert from Kelvin to C
            weatherData.city = json["name"].stringValue
            weatherData.condition = json["weather"][0]["id"].intValue
            weatherData.updateWeatherIcon()
            updateUIWithWeatherData()
        } else {
            print("Error: Code is \(code). \(json["message"].stringValue)")
            cityLabel.text = "Weather data unavailable"
        }
    }
   
    //MARK: - UI Updates
    /***************************************************************/
    func updateUIWithWeatherData() {
        cityLabel.text = weatherData.city
        temperatureLabel.text = String(weatherData.temperature)
        weatherIcon.image = UIImage(named: weatherData.weatherIconName)
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            
            let apiParams : [String : String] = ["lat" : String(location.coordinate.latitude), "lon" : String(location.coordinate.longitude), "appid" : APP_ID]
            getWeatherData(url: WEATHER_URL, params: apiParams)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    func userSelectedNew(city: String) {
        print(city)
    }
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            var changeCityViewController = segue.destination as! ChangeCityViewController
            changeCityViewController.changeCityDelegate = self
        }
    }
    
    
    
    
    
}


