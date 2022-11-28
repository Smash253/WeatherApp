//
//  SearchView.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 05.09.2022.
//

import SwiftUI



struct SearchView: View {
    
    
    
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
                        goButton   
                    }
                }
                .padding()
                .navigationTitle("Weather App")
                .navigationBarTitleDisplayMode(.large)
                
                
                if viewmodel.isSearching {
                    Loading()
                        
                }
            }
            .background(NavigationLink(
                destination: activeNavigationLinkDestination,
                isActive: $viewmodel.navigationLinkIsActive,
                label: EmptyView.init)
            )
            
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
    
    var goButton: some View {
        Button {
            viewmodel.goButtonTapped()
            
        } label: {
            Text(viewmodel.isSearching ? "Searching..." : "Go")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(viewmodel.isSearching ? Color.gray : Color.blue)
                .cornerRadius(20)
                .disabled(viewmodel.isSearching)
        
            
        }
    }
    
    
    @ViewBuilder
    var activeNavigationLinkDestination: some View {
        switch viewmodel.activeNavigationLinkDestination {
        case .none:
            EmptyView()
            
        case .weatherView(let weatherModel):
            WeatherView(weatherModel: weatherModel)
        }
    }
}

struct Loading: View {
    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(3)
        }
    }
}
