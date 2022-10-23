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
    }
    
}


