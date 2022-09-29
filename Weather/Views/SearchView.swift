//
//  SearchView.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 05.09.2022.
//

import SwiftUI



struct SearchView: View {
    
//    @StateObject var weatherviewmodel: WeatherViewModel
//    init(weatherviewmodel: WeatherViewModel) {
//        self._weatherviewmodel = StateObject(wrappedValue: weatherviewmodel)
//    }
    
    @StateObject var viewmodel: SearchViewModel
    init(viewmodel: SearchViewModel) {
        self._viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        
        NavigationView {
        
            ZStack {
                Color.backgroundColor.ignoresSafeArea(edges: .all)
                VStack {
                    searchBar
                    Spacer()
                    if !viewmodel.searchCity.isEmpty {
                        nextButton
                    }
                }
                .padding()
                .navigationTitle("Weather App")
                .navigationBarTitleDisplayMode(.large)

            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewmodel: SearchViewModel())
    }
}

fileprivate extension SearchView {
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Enter city...", text: $viewmodel.searchCity)
        }
        .padding(10)
        .background(Color(.systemGray5))
        .cornerRadius(20)
    }
    
    var nextButton: some View {
        
        NavigationLink {
            WeatherView(searchedCity: $viewmodel.searchCity)
                .navigationTitle(viewmodel.searchCity)
                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .principal) {
//                        Text("Back")
//                    }
//                }
                
        }
    label: {
            Text("GO")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(20)
        }
        
    }
}
