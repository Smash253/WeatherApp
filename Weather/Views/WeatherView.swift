//
//  WeatherView.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 05.09.2022.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var viewmodel = WeatherViewModel()
    @StateObject var callApi = APIService()
    @Binding var searchedCity: String
//    let weatherData: [WeatherModel] = []
   
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundColor.ignoresSafeArea(edges: .all)
                VStack(alignment: .leading, spacing: 50) {
//                    ForEach(weatherData, id: \.self) { weather in
//                        Text("\(weather.location.name)")
//                    }
                

                temperature
                clothes
                Spacer()
                
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                .onAppear(perform: {
                    self.callApi.apiCall(searchedCity: "\(searchedCity)", completion: {weatherModel in
                        
                        
                    } )
                })
                
            }
            
        }
                
    }
}

struct WeatherView_Previews: PreviewProvider {
    @State static var searchedCity: String = ""
    static var previews: some View {
        WeatherView(searchedCity: $searchedCity)
    }
}

fileprivate extension WeatherView {
    
    
    var temperature: some View {
        Text("It is  C with ? and ? winds")
            .fontWeight(.medium)
    }
    
    var clothes: some View {
        Text("Wear a ?")
            .fontWeight(.medium)
    }
}
