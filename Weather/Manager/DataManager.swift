import Foundation

class DataManager {
  private let apiService = APIService()

  enum RequestType {
    case getCurrentWeather(searchedCity: String)
    case postWeatherData(city: String, requestBody: [String: Any])
  }

  func performRequest<T: Decodable>(_ requestType: RequestType) async throws -> T {
    switch requestType {
    case .getCurrentWeather(let city):
      return try await apiService.getCurrentWeather(searchedCity: city) as! T
    case .postWeatherData(let city, let requestBody):
      return try await apiService.postWeatherData(city: city, requestBody: requestBody) as! T
    }
  }
}
