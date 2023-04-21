//
//  WeatherManager.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//

import Foundation
import CoreLocation

// By convention in Swift, we create a protocol in the same file as the class that will use the protocol.
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    //    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=69909afa26903a28166857e723462128&units=imperial&q=London"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=69909afa26903a28166857e723462128&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(from CityName: String) {
        let urlString = "\(weatherURL)&q=\(CityName)"
        //        print(urlString)
        performURLRequest(with: urlString)
    }
    
    // Using Geo-coordinates: https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=69909afa26903a28166857e723462128
    // Example: https://api.openweathermap.org/data/2.5/weather?appid=69909afa26903a28166857e723462128&lat=37.33233141&lon=-122.0312186

    
    func fetchWeather(latitude: CLLocationDegrees, Longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(Longitude)"
        performURLRequest(with: urlString)
    }
    
    func performURLRequest(with urlString: String) {
        // 1. Create a URL
        // url is an optional type as string might be invalid
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            //            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            //            let task = session.dataTask(with: url) { <#Data?#>, <#URLResponse?#>, <#Error?#> in
            //                <#code#>
            //            }
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
//                    print(error!)
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
//                    parseJSON(weatherData: safeData)
                    if let weather = parseJSON(safeData) {
                        // Method 1:
                        // let weatherVC = WeatherViewController()
                        // * add didUpdateWeather(weather: WeahterModel) {} in weatherVC
                        // weatherVC.didUpdateWeather(weather)
                        // --> This is a bad practice as it is tied to one type of object (weatherVC) so NOT reusable --> use delegate pattern
                        
                        // Method 2: Better using a delegate pattern
                        // 1.
                        delegate?.didUpdateWeather(self, weather: weather)
                        
                        // 2. define var delegate: WeatherManagerDelegate?
                        // 3. create a protocol
                        // 4. adopt a delegate protocol in weatherVC
                        // 5. set the weatherVC as the delegate:         weatherManager.delegate = self
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
            
        }
        
        // Data type is a type returned from .dataTask function above
        func parseJSON(_ weatherData: Data) -> WeatherModel? {
            let decoder = JSONDecoder()
            // decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
            // "Call can throw, but it is not marked with 'try' and the error is not handled"
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                
//                print(decodedData.name)
//                print(decodedData.main.temp)
//                print(decodedData.weather[0].description)
//                print(decodedData.weather[0].id)
                
                let id = decodedData.weather[0].id
                let name = decodedData.name
                let temp = decodedData.main.temp
                
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                
//                print(weather.conditionName)
//                print(weather.temperature)
//                print(weather.tempString)
                return weather
                
            } catch { // if it does throw an error
//                print(error)
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }
    
    // closures: anonymous function
    //    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
    //        if error != nil {
    //            print(error!)
    //            return
    //        }
    //
    //        if let safeData = data {
    //            let dataString = String(data: safeData, encoding: .utf8)
    //            print(dataString)
    //        }
    //    }
}
