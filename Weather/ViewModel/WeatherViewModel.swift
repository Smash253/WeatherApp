//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 13.09.2022.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var temp_c: Decimal = 0
    @Published var wind_kph: Decimal = 0
    
   
}


