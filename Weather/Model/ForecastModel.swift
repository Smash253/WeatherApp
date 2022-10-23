//
//  ForecastModel.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 07.09.2022.
//

import Foundation

struct WeatherModel: Codable, Hashable {
    var location: Location
    var current: Current
    
    static func emtpy() -> WeatherModel {
        WeatherModel(location: Location(name: ""), current: Current(temp_c: 0, wind_kph: 0))
    }
}

struct Location: Codable, Hashable {
    var name: String
}
struct Current: Codable, Hashable {
    var temp_c: Double
    var wind_kph: Double
}

