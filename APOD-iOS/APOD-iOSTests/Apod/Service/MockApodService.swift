import Foundation

enum MockError: Error {
    case networkError
}

final class MockApodService: ApodFetching {
    
    var isError: Bool = false
    
    private func returnApod(for date: String?) -> Apod {
        switch date {
        case Constants.Dates.testDate:
            return Apod.testValue
        case Constants.Dates.videoDate:
            return Apod.videoData
        default:
            return Apod.testValue
        }
    }
    
    // Return mock apod on success and throw error in case.
    func getApod(for params: [String : String]) async -> Result<Apod, AppError> {
        return isError ? .failure(AppError.NetworkManagerError(.networkError)) : .success(returnApod(for: params["date"]))
    }
    
    func getList(for params: [String : String]) async throws -> Result<[Apod], AppError> {
        // Do it Later
        return isError ? .failure(.NetworkManagerError(.networkError)) : .success([Apod.testValue])
    }
}
