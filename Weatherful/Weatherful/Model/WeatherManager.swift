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
    func didUpdateForecast(_ weatherManager: WeatherManager, forecastArray: [DailyForecastModel])
    func didFailWithError(error: Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=69909afa26903a28166857e723462128&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    // MARK: - by City Name
    func fetchWeather(from cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performURLRequest(with: urlString)
    }
    
    // MARK: - by Geo-coordinates
    // Using Geo-coordinates: https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=69909afa26903a28166857e723462128
    // Example: https://api.openweathermap.org/data/2.5/weather?appid=69909afa26903a28166857e723462128&lat=37.33233141&lon=-122.0312186
    func fetchWeather(latitude: CLLocationDegrees, Longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(Longitude)"
        performURLRequest(with: urlString)
    }
    
    // MARK: - Forecast
    // Forecast: http://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
    // https://api.openweathermap.org/data/2.5/forecast?appid=69909afa26903a28166857e723462128&lat=37.33233141&lon=-122.0312186
    
    func fetchForecast(from cityName: String) {
        let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=69909afa26903a28166857e723462128&units=imperial"
        let urlString = "\(weatherURL)&q=\(cityName)"
        performURLRequestForecast(with: urlString)
    }
    
    func performURLRequest(with urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            // 3. Create a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    // 1. obtain safe data
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
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
                let id = decodedData.weather[0].id
                let cityName = decodedData.name
                let weatherDescription = decodedData.weather[0].description.firstCapitalized
                let temp = decodedData.main.temp
                let temp_max = round(decodedData.main.temp_max * 10) / 10
                let temp_min = round(decodedData.main.temp_min * 10) / 10
                
                let weather = WeatherModel(conditionId: id, cityName: cityName, temp: temp, temp_max: temp_max, temp_min: temp_min, conditionDescription: weatherDescription)
                return weather
                
            } catch { // if it does throw an error
                //                print(error)
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }
    
    
    func fetchForecast(latitude: CLLocationDegrees, Longitude: CLLocationDegrees) {
        let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=69909afa26903a28166857e723462128&units=imperial"
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(Longitude)"
        performURLRequestForecast(with: urlString)
    }
    
    /*
    
    func performURLRequest(with urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            // 3. Create a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    // 1. obtain safe data
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
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
                let id = decodedData.weather[0].id
                let cityName = decodedData.name
                let weatherDescription = decodedData.weather[0].main
                let temp = decodedData.main.temp
                let temp_max = round(decodedData.main.temp_max * 10) / 10
                let temp_min = round(decodedData.main.temp_min * 10) / 10
                
                let weather = WeatherModel(conditionId: id, cityName: cityName, temp: temp, temp_max: temp_max, temp_min: temp_min, conditionDescription: weatherDescription)
                return weather
                
            } catch { // if it does throw an error
                //                print(error)
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }
    */
    
    func performURLRequestForecast(with urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            // 3. Create a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    // 1. obtain safe data
                    if let forecastArray = parseJSON(safeData) {
                        delegate?.didUpdateForecast(self, forecastArray: forecastArray)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
        
        func parseJSON(_ forecastData: Data) -> [DailyForecastModel]? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
                
                var forecastArray = [DailyForecastModel]()
                
                for index in 0...20 {
//                    let index = i * 8
                    let dailyForecastData = decodedData.list[index]
                    let dateString = convertDate(dateCode: dailyForecastData.dt)
                    let day = NSDate(timeIntervalSince1970: TimeInterval(dailyForecastData.dt)).description
                    let dayString = getDayOfWeekString(today: String(Array(day)[0...9]))
                    let time = formatTime(time: String(Array(day)[11...15]))
                    print(dayString)
                    print(dateString)
                    print(day)
                    print(time)
                    let conditionID = dailyForecastData.weather[0].id
                    let temp_max = round(dailyForecastData.main.temp_max * 10) / 10
                    let temp_min = round(dailyForecastData.main.temp_min * 10) / 10
                    
                    let forecast = DailyForecastModel(date: dateString,
                                                      day: dayString,
                                                      time: time,
                                                      conditionId: conditionID,
                                                      max_temp: temp_max,
                                                      min_temp: temp_min)
                    forecastArray.append(forecast)
                }
                return forecastArray
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
        
    }
    
    private func convertDate(dateCode: Int) -> String {
        let date = NSDate(timeIntervalSince1970: Double(dateCode))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        let dateString: String = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    private func getDayOfWeekString(today: String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        switch weekDay {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            print("Error fetching days")
            return "Day"
        }
    }
    
    private func formatTime(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm"
        let date12 = dateFormatter.date(from: time)!
        
        dateFormatter.dateFormat = "h:mm a"
        let date22 = dateFormatter.string(from: date12)
        return date22
    }
}
