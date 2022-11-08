//
//  SearchViewModel.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 07.09.2022.
//

import Foundation

enum SearchViewNavigationDestinationType {
    case none
    case weatherView(weatherModel: WeatherModel)
}

class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var searchCity: String = ""
    private let apiService = APIService()
    @Published var navigationLinkIsActive: Bool = false
    @Published var activeNavigationLinkDestination: SearchViewNavigationDestinationType = .none
    @Published var isSearching: Bool = false
    
    
    // MARK: - Methods
    func goButtonTapped() {
        isSearching = true
        apiService.apiCall(searchedCity: searchCity){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)

            case .success(let weatherModel):
                DispatchQueue.main.async {
                    self.activeNavigationLinkDestination = .weatherView(weatherModel: weatherModel)
                    self.navigationLinkIsActive = true
                }
            }

            DispatchQueue.main.async {
                self.isSearching = false
            }
        }
        
        
        
    }
}


