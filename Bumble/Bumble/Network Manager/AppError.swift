import Foundation

enum AppError: Error, LocalizedError {
    case NetworkManagerError(NetworkError)
    
    var errorDescription: String? {
        switch self {
        case .NetworkManagerError(let error):
            return error.localizedDescription
        }
    }
}

extension AppError {
    static let genericErrorMessage = "Unable to load the requested content. Please try again later."
    static let timeoutMessage = "Request timed out. Please try again."
    static let serverErrorMessage = "We are facing some issue server side. Please try again."
    static let decodingErrorMessage = "We encountered an issue while processing the data. Please try again."
    static let noInternetMessage = "Please turn on your internet connection."
    static let invalidResponse = "The server returned an invalid response. Please try again later."
}
