import Foundation


protocol HomeFetching {
    func fetchMovies() async  -> Result<Page<Movie>, AppError>
}

final class HomeViewService: HomeFetching {
    
    private let networkManager: NetworkFetching
    
    init(networkManager: NetworkFetching = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchMovies() async  -> Result<Page<Movie>, AppError> {
        do {
            return try await networkManager.getData(request: Movie.topRated)
        } catch {
            return .failure(.NetworkManagerError(.networkError))
        }
    }
}
