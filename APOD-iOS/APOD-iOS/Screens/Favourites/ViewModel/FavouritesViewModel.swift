import Foundation
import Combine

enum FavouritesState {    
    case loading
    case loaded([Apod])
    case groupped([FavouritesViewModel.FavouriteSections])
    case error(String)
    
    var items: [Apod]? {
        switch self {
        case .loaded(let items):
            return items
            
        case .loading, .error(_), .groupped(_):
            return nil
        }
    }
    
    var groupped: [FavouritesViewModel.FavouriteSections] {
        switch self {
        case .groupped(let groups):
            return groups
        case .loading, .loaded(_), .error(_):
            return []
        }
    }
}



final class FavouritesViewModel: ObservableObject {
    private let dataRepo: ApodDataFetching
    private let dateFormatting: DateFormatting
    @Published var state: FavouritesState = .loading
    @Published var searchTerm: String = ""
    @Published private var apodItems: [Apod] = []
    private var cancellable = Set<AnyCancellable>()
    @Published var groups: [FavouriteSections] = []
    
    struct FavouriteSections: Equatable {
        let title: String
        let rows: [Apod]
    }

    init(dataRepo: ApodDataFetching = DependencyManager.apodDataRepo, dateformatting: DateFormatting = DefaultDateFormatter()) {
        self.dataRepo = dataRepo
        self.dateFormatting = dateformatting
        grouppedFavourites()
    }
    
    @MainActor
    func fetchList() async {
        apodItems = await dataRepo.fetchFavourites()
        state = .loaded(apodItems)
    }
    
    func searchText() {
        $searchTerm
            .combineLatest($apodItems)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterItems)
            .sink { [weak self] returnedItems in
                self?.state = .loaded(returnedItems)
            }.store(in: &cancellable)
    }
    
    private func grouppedFavourites() {
        $state
            .compactMap { favState -> [FavouriteSections] in
                guard case .loaded(let items) = favState else { return [] }
                let groupedItem = Dictionary(grouping: items) { element in
                    self.grouppedDated(date: element.date)
                }
                
                return groupedItem
                    .sorted(by: {self.grouppedDated(date: $0.key) > self.grouppedDated(date: $1.key)})
                    .map({FavouriteSections(title: $0.key, rows: $0.value)})
            }
            .sink { [weak self] sections in
                self?.groups = sections
            }.store(in: &cancellable)
    }
    
    func convertStringToDate(date: String) -> Date {
        dateFormatting.dateFromString(date, dateStyle: .short)
    }
    
    private func filterItems(text: String, items: [Apod]) -> [Apod] {
        guard !text.isEmpty else {
            return items
        }
        let lowerCaseText = text.lowercased()
        return items.filter { apod in
            return apod.title.lowercased().contains(lowerCaseText) || apod.explanation.lowercased().contains(lowerCaseText)
        }
    }
    
    private func grouppedDated(date: String) -> String {
        let groupDate = dateFormatting.dateFromString(date, dateStyle: .short)
        return dateFormatting.stringFromDate(date: groupDate, dateStyle: .monthOnly)
    }
    
    @MainActor
    func toggleFavourite(for element: Apod, index: Int) async {
        var item = element
        item.isFavourite.toggle()
        
        await dataRepo.updateElement(for: item)
        
        guard var favItems = state.items else {return}
        favItems.remove(at: index)
        state = .loaded(favItems)
        
        
    }
}
