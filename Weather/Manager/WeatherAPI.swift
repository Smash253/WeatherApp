import Foundation
import Security

class KeychainHelper {
  
  static let shared = KeychainHelper()

  private init() {}

  func save(key: String, data: Data) -> OSStatus {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key,
      kSecValueData as String: data
    ]

    SecItemDelete(query as CFDictionary)
    return SecItemAdd(query as CFDictionary, nil)
  }

  func load(key: String) -> Data? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne
    ]

    var dataTypeRef: AnyObject? = nil
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
    
    if status == errSecSuccess {
      return dataTypeRef as? Data
    } else {
      return nil
    }
  }

  func delete(key: String) {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key
    ]

    SecItemDelete(query as CFDictionary)
  }
}

class APIService: ObservableObject {

  private let apiKeyKeychainKey = "Nick.Weather.weatherAPIKey"
  private let weatherKey = ""

  init() {
    if getAPIKey() == nil {
      storeAPIKey(weatherKey)
    }
  }

  func apiRequest<T: Decodable>(
    endpoint: String,
    method: String,
    queryItems: [URLQueryItem] = [],
    body: Data? = nil
  ) async throws -> T {
    guard let apiKey = getAPIKey() else {
      throw APIError.http401APIKeyNotProvided
    }

    guard let url = buildURL(endpoint: endpoint, queryItems: queryItems) else {
      throw APIError.http400APIRequestUrlInvalid
    }

    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = body

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
      throw APIError.http400InternalApplicationError
    }

    do {
      let decodedResponse = try JSONDecoder().decode(T.self, from: data)
      return decodedResponse
    } catch {
      throw error
    }
  }

  func getCurrentWeather(searchedCity: String) async throws -> WeatherModel {
    let formattedCity = searchedCity.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "_")
    return try await apiRequest(
      endpoint: "/v1/current.json",
      method: "GET",
      queryItems: [
        URLQueryItem(name: "key", value: getAPIKey()),
        URLQueryItem(name: "q", value: formattedCity),
        URLQueryItem(name: "aqi", value: "no")
      ]
    )
  }

  func postWeatherData(city: String, requestBody: [String: Any]) async throws -> WeatherModel {
    let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
    return try await apiRequest(
      endpoint: "/v1/current.json",
      method: "POST",
      queryItems: [
        URLQueryItem(name: "key", value: getAPIKey()),
        URLQueryItem(name: "q", value: city),
        URLQueryItem(name: "aqi", value: "no")
      ],
      body: jsonData
    )
  }

  private func buildURL(endpoint: String, queryItems: [URLQueryItem]) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.weatherapi.com"
    components.path = endpoint
    components.queryItems = queryItems
    return components.url
  }
}

private extension APIService {
  func getAPIKey() -> String? {
    guard let data = KeychainHelper.shared.load(key: apiKeyKeychainKey) else { return nil }
    return String(data: data, encoding: .utf8)
  }

  func storeAPIKey(_ apiKey: String) {
    guard let data = apiKey.data(using: .utf8) else { return }
    _ = KeychainHelper.shared.save(key: apiKeyKeychainKey, data: data)
  }
}
