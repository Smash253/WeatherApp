//
//  WeatherView.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 05.09.2022.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @State var showFarenheit: Bool = false
    // MARK: - Init
    init(weatherModel: WeatherModel) {
        self._viewModel = StateObject(wrappedValue: WeatherViewModel(weatherModel: weatherModel))
    }
    
    
    func changeResult() -> String {
         showFarenheit ? viewModel.farenheit() : viewModel.temp_c.formatted()
         
    }
    
    func changeDegrees() -> String {
        showFarenheit ? "°F" : "°C"
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color.backgroundColor.ignoresSafeArea(edges: .all)
                VStack(alignment: .leading, spacing: 30) {
                temperature
                clothes
                button
                        
                }
                .padding(.horizontal)
                .allowsTightening(true)
                .multilineTextAlignment(.leading)
                
                
                
                
            }
        }
        //.navigationBarTitle(viewModel.name)
        .navigationBarTitle(viewModel.name, displayMode: .inline)
    }
}

struct WeatherView_Previews: PreviewProvider {
    
    static var previews: some View {
        WeatherView(weatherModel: .emtpy())
    }
}

fileprivate extension WeatherView {
    
    
    var temperature: some View {
        Text("It is \(changeResult()) \(changeDegrees()) and \(viewModel.wind_kph.formatted()) km/h winds")
            .fontWeight(.medium)
            .foregroundColor(.white)
            .font(.title)
            
        
    }
    
    var clothes: some View {
        Text("You should \(viewModel.forecast()).")
            .fontWeight(.medium)
            .foregroundColor(.white)
            .font(.title)
            
    }
    
    
    var button: some View {
        Button("Push") {
            showFarenheit.toggle()
            
        }
        .font(.headline)
        .foregroundColor(Color.white)
        .frame(width: 100, height: 50)
        .background(Color.blue)
        .cornerRadius(20)
    }
}
    

