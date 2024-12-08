import Foundation


final class HomeViewModel: ObservableObject {
    struct MovieSection: Hashable {
        var title: String
        var movies: [Movie]
    }
    
    private let homeService: HomeFetching
    @Published var movies: [Movie] = []
    @Published var recentMovies: [Movie] = []
    @Published var sections: [MovieSection] = []
    @Published var errorString: String = "Some Error."
    @Published var user: User = User.mockUser
    @Published var selectedMovie: Movie? = nil
    @Published var showBottom: Bool = false
    
    init(homeService: HomeFetching = HomeViewService()) {
        self.homeService = homeService
    }
    
    @MainActor
    func getData() async {
        let result = await homeService.fetchMovies()
        
        switch result {
            
        case .success(let page):
            self.movies = page.results
            self.getRecentMovies(page.results)
            self.getMovieSections(page.results)
        case .failure(let error):
            self.errorString = error.localizedDescription
        }
    }
    
    func getRecentMovies(_ movies: [Movie]) {
        self.recentMovies = Array(movies.prefix(8))
    }
    
    func getMovieSections(_ movies: [Movie]) {
        var moviesvalues: [MovieSection] = []
        let _: () = Dictionary(grouping: movies) { movie in
            movie.genre
        }.forEach { title, items in
            let movieSection = MovieSection(title: title, movies: items + items)
            moviesvalues.append(movieSection)
        }
        self.sections = moviesvalues
    }
}
