import SwiftUI

struct WeatherDetailsView: View {
  @StateObject var viewModel: WeatherDetailViewModel

  var body: some View {
    VStack(spacing: 30) {
      Text("Weather in \(viewModel.weatherModel.location.name)")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.primary)
        .padding(.top, 20)

      VStack(spacing: 10) {
        Text("Temperature")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(.secondary)
        Text("\(viewModel.formattedTemperature)°\(viewModel.isMetric ? "C" : "F")")
          .font(.system(size: 60, weight: .bold))
          .foregroundColor(.blue)

        Text("Wind Speed")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(.secondary)
        Text("\(viewModel.formattedWindSpeed) \(viewModel.isMetric ? "kph" : "mph")")
          .font(.system(size: 50, weight: .bold))
          .foregroundColor(.blue)
      }

      Spacer()

      Button(action: {
        withAnimation {
          viewModel.toggleUnitSystem()
        }
      }) {
        Text("Switch to \(viewModel.isMetric ? "Fahrenheit & mph" : "Celsius & kph")")
          .font(.headline)
          .foregroundColor(.white)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .cornerRadius(10)
          .padding(.horizontal, 20)
      }
      .padding(.bottom, 30)
    }
    .padding()
  }
}
