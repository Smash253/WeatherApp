//
//  WeatherAPI.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 07.09.2022.
//

import Foundation

class APIService: ObservableObject {
//    @Published var temp_c: Decimal
//    @Published var wind_kph: Decimal
//completion: @escaping (([WeatherModel]) -> ()),
    func apiCall(searchedCity: String, completion: @escaping ((WeatherModel) -> Void )) {
     let apikey = "686a24c285be4072bde75136220702"
    guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apikey)&q=\(searchedCity)&aqi=no") else {
        return
    }
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        do {
            let response = try JSONDecoder().decode(WeatherModel.self, from: data)
            
            print(response)
            print("SUCCESS")
        }
        catch {
            print(error)
        }
    }
    task.resume()
}
    
}

