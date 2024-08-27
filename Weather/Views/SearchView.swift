import SwiftUI

struct SearchView: View {
  @StateObject private var viewModel = SearchViewModel()
  @FocusState private var isTextFieldFocused: Bool
  @State private var navigateToDetail: Bool = false

  var body: some View {
    NavigationView {
      VStack {
        Text("Weather Search")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.top, 40)
          .foregroundColor(.primary)

        TextField("Enter city name", text: $viewModel.cityName)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
          .focused($isTextFieldFocused)
          .cornerRadius(8)
          .padding(.horizontal, 20)

        Spacer()

        Button(action: {
          Task {
            await viewModel.searchWeather()
            isTextFieldFocused = false
            if case .success(_) = viewModel.viewState {
              navigateToDetail = true
            }
          }
        }) {
          Text("Get Weather")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal, 20)
        }
        .padding()

        switch viewModel.viewState {
        case .loading:
          ProgressView()
            .scaleEffect(1.5, anchor: .center)
            .padding()
        case .error(let message):
          Text("Error: \(message)")
            .foregroundColor(.red)
            .padding()
        case .success(_):
          NavigationLink(
            destination: WeatherDetailsView(viewModel: WeatherDetailViewModel(weatherModel: viewModel.weatherModel)),
            isActive: $navigateToDetail,
            label: { EmptyView() }
          )
        }
      }
      .onAppear {
        isTextFieldFocused = true
      }
    }
  }
}
