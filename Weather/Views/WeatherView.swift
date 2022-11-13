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
                VStack(alignment: .leading, spacing: 30) {
                    
                temperature
                clothes
                }
                .foregroundColor(.white)
                .font(.title)
            }
        }
        .navigationBarTitle(viewModel.name)
    }
}

struct WeatherView_Previews: PreviewProvider {
    
    static var previews: some View {
        WeatherView(weatherModel: .emtpy())
    }
}

fileprivate extension WeatherView {
    
    
    var temperature: some View {
        Text("It is \(viewModel.temp_c.formatted())°C and \(viewModel.wind_kph.formatted()) kph winds")
            .fontWeight(.medium)
            
        
    }
    
    var clothes: some View {
        Text("You should \(viewModel.forecast()).")
            .fontWeight(.medium)
    }
   

}
    

