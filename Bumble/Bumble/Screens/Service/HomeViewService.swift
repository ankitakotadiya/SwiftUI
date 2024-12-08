import Foundation


protocol HomeFetching {
    func fetchMovies() async  -> Result<Page<User>, AppError>
}

final class HomeViewService: HomeFetching {
    
    private let networkManager: NetworkFetching
    
    init(networkManager: NetworkFetching = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchMovies() async  -> Result<Page<User>, AppError> {
        do {
            return try await networkManager.getData(request: User.topUsers)
        } catch {
            return .failure(.NetworkManagerError(.networkError))
        }
    }
}
