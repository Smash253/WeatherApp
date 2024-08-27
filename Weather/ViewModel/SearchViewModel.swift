import Foundation

@MainActor
class SearchViewModel: ObservableObject {
  @Published var cityName: String = ""
  @Published var viewState: ViewState = .success(.empty())
  var weatherModel: WeatherModel = .empty()

  private let dataManager = DataManager()

  func searchWeather() async {
    guard !cityName.isEmpty else {
      viewState = .error("City name cannot be empty.")
      return
    }

    viewState = .loading

    do {
      weatherModel = try await dataManager.performRequest(.getCurrentWeather(searchedCity: cityName))
      viewState = .success(weatherModel)
    } catch {
      viewState = .error(error.localizedDescription)
    }
  }
}


enum ViewState {
  case loading
  case error(String)
  case success(WeatherModel)
}
