//
//  WeatherData.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/20/23.
//

import Foundation

// https://api.openweathermap.org/data/2.5/weather?appid=69909afa26903a28166857e723462128&units=imperial&q=London

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Main: Decodable {
    // property name should match with JSON property name
    let temp: Double
}

// weather type is an array
struct Weather: Decodable {
    let id: Int
    let description: String
}
