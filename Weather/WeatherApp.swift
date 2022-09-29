//
//  WeatherApp.swift
//  Weather
//
//  Created by Darie Nistor Nicolae on 05.09.2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            //WeatherView()
            SearchView(viewmodel: SearchViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
