//
//  ForecastData.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//

//import Foundation
//
//// https://api.openweathermap.org/data/2.5/forecast?appid=69909afa26903a28166857e723462128&lat=37.33233141&lon=-122.0312186

struct ForecastData: Decodable {
//    let city: City
    let list: [List]
}

struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
}
