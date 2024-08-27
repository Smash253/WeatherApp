import Foundation

enum APIError: Int, Error {
  // 401 Errors
  case http401APIKeyNotProvided = 1002
  case http401APIKeyInvalid = 2006

  // 400 Errors
  case http400ParameterQNotProvided = 1003
  case http400APIRequestUrlInvalid = 1005
  case http400NoLocationFound = 1006
  case http400JsonBodyInvalid = 9000
  case http400JsonBodyTooManyLocations = 9001
  case http400InternalApplicationError = 9999

  // 403 Errors
  case http403APIKeyExceededQuota = 2007
  case http403APIKeyDisabled = 2008
  case http403APIKeyNoAccess = 2009

  var message: String {
    switch self {
    case .http401APIKeyNotProvided:
      return "API key not provided."
    case .http400ParameterQNotProvided:
      return "Parameter 'q' not provided."
    case .http400APIRequestUrlInvalid:
      return "API request URL is invalid."
    case .http400NoLocationFound:
      return "No location found matching parameter 'q'."
    case .http401APIKeyInvalid:
      return "API key provided is invalid."
    case .http403APIKeyExceededQuota:
      return "API key has exceeded calls per month quota."
    case .http403APIKeyDisabled:
      return "API key has been disabled."
    case .http403APIKeyNoAccess:
      return "API key does not have access to the resource. Please check the pricing page for what is allowed in your API subscription plan."
    case .http400JsonBodyInvalid:
      return "JSON body passed in bulk request is invalid. Please make sure it is valid JSON with UTF-8 encoding."
    case .http400JsonBodyTooManyLocations:
      return "JSON body contains too many locations for bulk request. Please keep it below 50 in a single request."
    case .http400InternalApplicationError:
      return "Internal application error."
    }
  }
}
