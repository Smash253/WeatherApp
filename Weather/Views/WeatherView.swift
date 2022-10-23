//
//  WeatherView.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 05.09.2022.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var viewModel: WeatherViewModel
    
    
    // MARK: - Init
    init(weatherModel: WeatherModel) {
        self._viewModel = StateObject(wrappedValue: WeatherViewModel(weatherModel: weatherModel))
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundColor.ignoresSafeArea(edges: .all)
                VStack(alignment: .leading, spacing: 50) {
//                    ForEach(weatherData, id: \.self) { weather in
//                        Text("\(weather.location.name)")
//                    }
                

                temperature
                
                
                
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                
            }
            
        }
                
    }
}

struct WeatherView_Previews: PreviewProvider {
    @State static var searchedCity: String = ""
    static var previews: some View {
        WeatherView(weatherModel: .emtpy())
    }
}

fileprivate extension WeatherView {
    
    
    var temperature: some View {
        Text("It is \(viewModel.temp_c)°C with ? and \(viewModel.wind_kph) kph winds")
            .fontWeight(.medium)
    }
    
}
