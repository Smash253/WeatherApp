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
    
    enum Weather {
        case hot, warm, cold, freezing
    }
    
    func forecast() -> String {
        
//        switch cast {
//        case .hot:
//            temp_c > 30.0 && temp_c > 22.0
//            return "Wear shorts"
//        case .warm:
//            temp_c < 22.0 && temp_c > 14.0
//            return "Wear a sweater"
//        case .cold:
//            temp_c < 13.0 && temp_c > 0
//            return "Wear a jacket"
//        case .freezing:
//            temp_c < 0
//            return "Wear a heavy jacket"
//        default:
//            return "no work"
//        }
        
        if temp_c > 30.0 && temp_c > 22.0 {
            return "Wear shorts"
        } else if temp_c < 22.0 && temp_c > 14.0 {
            return "Wear a sweater"
        } else if temp_c < 13.0 && temp_c > 0 {
            return "Wear a jacket"
        } else if temp_c < 0 {
           return  "Wear a heavy jacket"
        } else {
            return "Not working"
        }
        
    }
    
    func farenheit() -> String {
        let farenheit = (temp_c * 9/5) + 32
        return farenheit.formatted()
        
        
    }
    
}

