//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 13.09.2022.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var temp_c: Double
    @Published var wind_kph: Double
    @Published var name: String
    
    // MARK: - Init
    init(weatherModel: WeatherModel) {
        self.temp_c = weatherModel.current.temp_c
        self.wind_kph = weatherModel.current.wind_kph
        self.name = weatherModel.location.name
        
    }
    
    
    func forecast() -> String {
        
        switch temp_c {
        case ...0:
            return "Wear a heavy jacket"
        case 0...13:
            return  "Wear a jacket"
        case 13...22:
            return "Wear a sweater"
        case 22...:
            return "Wear shorts"
        default:
            return "No working"
        }

//        let ddd: String = "sdsasd"
//        switch ddd {
//        case "Jacket"
//        }
        
    }
    
    func farenheit() -> String {
        let farenheit = (temp_c * 9/5) + 32
        return farenheit.formatted()
        
        
    }
    
}

