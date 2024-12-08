import Foundation


final class HomeViewModel: ObservableObject {
    
    private let homeService: HomeFetching
    @Published var users: [User] = []
    @Published var recentUsers: [User] = []
    @Published var errorString: String = "Some Error."
    
    init(homeService: HomeFetching = HomeViewService()) {
        self.homeService = homeService
    }
    
    @MainActor
    func getData() async {
        let result = await homeService.fetchMovies()
        
        switch result {
            
        case .success(let page):
            self.users = page.users
            self.getRecentUsers(page.users)
        case .failure(let error):
            self.errorString = error.localizedDescription
        }
    }
    
    func getRecentUsers(_ users: [User]) {
        self.recentUsers = Array(users.prefix(8))
    }
    
//    func getMovieSections(_ movies: [Movie]) {
//        let sectionTitles = ["Comedy", "Drama", "Action", "Love Story"]
//        var moviesvalues: [MovieSection] = []
//        for title in sectionTitles {
//            let items = Array(movies.shuffled().prefix(10))
//            let movieSection = MovieSection(title: title, movies: items)
//            moviesvalues.append(movieSection)
//        }
//        self.sections = moviesvalues
//    }
}
