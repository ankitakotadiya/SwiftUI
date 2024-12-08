import Foundation


import Foundation
import SwiftUI

protocol NetworkFetching {
    func getData<T: Decodable>(request: Request<T>) async throws -> Result<T, AppError>
    func downloadData(from url: URL?) async -> Result<Data, AppError>
}

// An enum representing different error types that can occur during network requests.
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case urlError(URLError)
    case networkError
        
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return AppError.genericErrorMessage
        case .invalidResponse:
            return AppError.invalidResponse
        case .decodingError:
            return AppError.decodingErrorMessage
        case .networkError:
            return AppError.serverErrorMessage
        case .urlError(let urlError):
            return mapURLError(urlError)
        }
    }
    
    // A helper function to map `URLError` to specific error messages.
    private func mapURLError(_ urlError: URLError) -> String {
        switch urlError.code {
        case .badURL, .unsupportedURL, .cannotFindHost:
            return AppError.genericErrorMessage
        case .timedOut, .networkConnectionLost, .secureConnectionFailed:
            return AppError.timeoutMessage
        case .cannotParseResponse, .cannotDecodeRawData:
            return AppError.decodingErrorMessage
        case .notConnectedToInternet:
            return AppError.noInternetMessage
        default:
            return AppError.serverErrorMessage
        }
    }
}

// A class responsible for handling network requests, implementing the NetworkFetching protocol.
final class NetworkManager: NetworkFetching {
    let api_key = API.apiKey
    let host = API.baseURL
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getData<T: Decodable>(request: Request<T>) async throws -> Result<T, AppError> {
        do {
            let urlRequest = try urlRequest(for: request)
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            // Check if response has valid HTTP status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(AppError.NetworkManagerError(.invalidURL))
            }
            
            do {
//                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(jsonObj)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(AppError.NetworkManagerError(.decodingError))
            }
            
        } catch let error as URLError {
            return .failure(AppError.NetworkManagerError(.urlError(error)))
        } catch {
            return .failure(AppError.NetworkManagerError(.networkError))
        }
    }
    
    // Downloads raw data from the given URL asynchronously.
    func downloadData(from url: URL?) async -> Result<Data, AppError> {
        do {
            guard let url = url else {
                return .failure(AppError.NetworkManagerError(.invalidURL))
            }
            let (data, response) = try await urlSession.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(AppError.NetworkManagerError(.invalidResponse))
            }
            
            return .success(data)
        } catch {
            return .failure(AppError.NetworkManagerError(.networkError))
        }
    }
    
    private func urlRequest<Value>(for _request: Request<Value>) throws -> URLRequest {
        guard let url = URL(host, api_key, _request) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = _request.method.rawValue
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return request
    }
}

extension URL {
    // Appends query items to the URL and returns the updated URL.
    func url(with queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        var existingComponents: [URLQueryItem] = components?.queryItems ?? []
        existingComponents.append(contentsOf: queryItems)
        components?.queryItems = existingComponents
        
        return components?.url
    }
    
    // Initializes a URL with a host, API key, and request, appending the appropriate query parameters.
    init?<Value>(_ host: String, _ apiKey: String, _ request: Request<Value>) {
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        queryItems += request.queryParams.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let baseURL = URL(string: host) else {
            return nil
        }
        
        let urlPath = baseURL.appendingPathComponent(request.path).url(with: queryItems)
        
        guard let urlString = urlPath?.absoluteString else {
            return nil
        }
        
        self.init(string: urlString)
    }
}
