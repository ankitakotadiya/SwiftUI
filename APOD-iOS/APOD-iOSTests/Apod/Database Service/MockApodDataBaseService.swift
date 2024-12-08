import Foundation

final class MockApodDataBaseService: ApodDataFetching {
    private let dateFormatter = DefaultDateFormatter()
    static let shared = MockApodDataBaseService()
    
    var apods: [Apod] = []
    var favourites: [Apod] = Apod.favourites
    
    // Fetch Apo
    func fetchApod(for date: String) async -> Apod? {
        return apods.filter({$0.date == date}).first
    }
    
    // In-Memory Save
    func saveApod(_ apod: Apod) async {
        apods.append(apod)
    }
    
    // Fetch Last Saved
    func fetchLatestApod() async -> Apod? {
        return apods.sorted(by: {dateFormatter.dateFromString($0.date, dateStyle: .short) > dateFormatter.dateFromString($1.date, dateStyle: .short)}).first ?? Apod.dummyObj
    }
    
    // Store only one record if cleanup occurs.
    func pruneRecordsIfNeeded() async {
        if apods.count > 1 {
            let count = apods.count - 1
            apods.removeLast(count)
        }
    }
    
    // Favourite on/off
    func updateElement(for item: Apod?) async {
        guard let favItem = item else {return}
        if favourites.isEmpty {
            favourites = Apod.favourites
        }
        
        if let index = favourites.firstIndex(where: {$0.id == item?.id}) {
            favourites[index] = favItem
        }
    }
    
    func fetchFavourites() async -> [Apod] {
        return favourites.filter({$0.isFavourite})
    }
}
