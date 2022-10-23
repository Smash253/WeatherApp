//
//  WeatherAPI.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 07.09.2022.
//

import Foundation

enum CustomError: Error {
    case wrongURL
    case missingData
}

class APIService: ObservableObject {

    func apiCall(searchedCity: String, completion: @escaping ((Result<WeatherModel, Error>) -> Void )) {
        let apikey = "686a24c285be4072bde75136220702"
        let searchedCityTrimmingWhiteSpaces = searchedCity.split(separator: " ").joined(separator: "_")
        print(searchedCityTrimmingWhiteSpaces)
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apikey)&q=\(searchedCityTrimmingWhiteSpaces)&aqi=no") else {
            completion(.failure(CustomError.wrongURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                completion(.failure(CustomError.missingData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(response))
            }
            catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
}
    
}

