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
    
    
    // MARK: - Init
    init(weatherModel: WeatherModel) {
        self.temp_c = weatherModel.current.temp_c
        self.wind_kph = weatherModel.current.wind_kph
        
        enum Weather {
            case hot, warm, cold, freezing
            
        }
        
        var forecast = Weather.hot
        
        switch forecast {
        case .hot:
            print("shorts")
        case .warm:
            print("a sweater")
        case .cold:
            print("a jacket")
        case .freezing:
            print("a heavy jacket")
        
        }
        
        if temp_c > 30 {
            print(Weather.cold)
        } else if temp_c > 30 {
            print(Weather.freezing)
        }
        
        
    }
    
    
    
    
    
//    func temp() {
//       enum Weather {
//            case hot, warm, cold, freezing
//        }
//        if temp_c > 30 && temp_c > 22 {
//            print("Wear shorts")
//        } else if temp_c < 22 && temp_c > 14 {
//            print("Wear a sweater")
//        } else if temp_c < 13 && temp_c > 0 {
//            print("Wear a jacket")
//        } else if temp_c < 0 {
//            print("Wear a heavy jacket")
//        }
//    }
    
}

