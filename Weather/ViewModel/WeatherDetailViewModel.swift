import Foundation

class WeatherDetailViewModel: ObservableObject {
  @Published var weatherModel: WeatherModel
  @Published var isMetric: Bool = true

  var formattedTemperature: String {
    let temperature = isMetric ? weatherModel.current.temp_c : celsiusToFahrenheit(weatherModel.current.temp_c)
    return String(format: "%.1f", temperature)
  }

  var formattedWindSpeed: String {
    let windSpeed = isMetric ? weatherModel.current.wind_kph : kphToMph(weatherModel.current.wind_kph)
    return String(format: "%.1f", windSpeed)
  }

  init(weatherModel: WeatherModel) {
    self.weatherModel = weatherModel
  }

  func toggleUnitSystem() {
    isMetric.toggle()
  }

  private func celsiusToFahrenheit(_ celsius: Double) -> Double {
    return (celsius * 9/5) + 32
  }

  private func kphToMph(_ kph: Double) -> Double {
    return kph * 0.621371
  }
}
