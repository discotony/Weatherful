//
//  WeatherModel.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temp: Double
    var temp_max: Double
    let temp_min: Double
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionDescription: String
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud_bolt"
        case 300...321:
            return "cloud_drizzle"
        case 500...531:
            return "cloud_rain"
        case 600...622:
            return "cloud_snow"
        case 701...781:
            return "cloud_fog"
        case 800:
            return "sun_max"
        case 801...804:
            return "cloud_bolt"
        default:
            return "cloud"
        }
    }
}


//struct ForecastModel {
//    let forecastArray: [DailyForecastModel]
//}

struct DailyForecastModel {
    let date: String
    let day: String
    let time: String
    let conditionId: Int
    let max_temp: Double
    let min_temp: Double
    var conditionName: String {
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
