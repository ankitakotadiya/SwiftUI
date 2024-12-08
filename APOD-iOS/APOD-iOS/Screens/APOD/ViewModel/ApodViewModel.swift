import Foundation
import Combine
import CoreData

enum ApodState: Equatable {
    static func == (lhs: ApodState, rhs: ApodState) -> Bool {
        return true
    }
    
    case loading
    case loaded(Apod?)
    case error(String)
    
    // A computed property to access the Apod object when the state is loaded, or nil for other states.
    var apod: Apod? {
        switch self {
        case .loaded(let apod):
            return apod
        case .loading, .error(_):
            return nil
        }
    }
    
    var errorString: String? {
        switch self {
        case .loaded(_), .loading:
            return nil
        case .error(let error):
            return error
        }
    }
}

@MainActor
final class ApodViewModel: ObservableObject {
    var apodService: ApodFetching
    var dateFormatting: DateFormatting
    var apodDataRepo: ApodDataFetching
    @Published var state: ApodState = .loading
    @Published var selectedDate: Date
    
    init(
        apodService: ApodFetching = DependencyManager.apodService,
        dateFormatting: DateFormatting = DefaultDateFormatter(),
        apodDataRepo: ApodDataFetching = DependencyManager.apodDataRepo,
        selectedDate: Date = Date.now
    ) {
        self.apodService = apodService
        self.dateFormatting = dateFormatting
        self.apodDataRepo = apodDataRepo
        self.selectedDate = selectedDate
        
        loadData()
    }
    
    // Loads the APOD for the specified date by first checking the local database, then fetching from the network if necessary, and finally updating the state.
    func load(strDate: String) async {
        state = .loading
        if let apodItem = await apodDataRepo.fetchApod(for: strDate) {
            self.state = .loaded(apodItem)
        } else {
            let result = await apodService.getApod(for: ["date": strDate])
            
            switch result {
            case .success(let apod):
//                self.state = .error("Request Time out")
                self.state = .loaded(apod)
                await saveItemtoDatabase(apod)
            case .failure(let error):
                print(error.localizedDescription)
                self.state = .loaded(await apodDataRepo.fetchLatestApod())
            }
        }
    }
    
    func toggleFavourite(_ date: Date) async {
        guard var apod = state.apod else {return}
        apod.isFavourite.toggle()
        state = .loaded(apod)
        
        await apodDataRepo.updateElement(for: apod)
    }
    
    func loadData() {
        Task {
            if ProcessInfo.processInfo.environment["ui_test_media"] == "video" {
                selectedDate = dateFormatting.dateFromString(Constants.Dates.videoDate, dateStyle: .short)
            }
            await load(strDate: dateFormatting.stringFromDate(date: selectedDate, dateStyle: .short))
        }
    }
    
    func cleanUpResource() async {
        await apodDataRepo.pruneRecordsIfNeeded()
        FileManagerCache().pruneRecords()
    }
    
    private func saveItemtoDatabase(_ _item: Apod) async {
        await apodDataRepo.saveApod(_item)
        
//        do {
//            try await apodDataRepo.saveApod(_item)
//        } catch let error {
//            self.state = .error(error.localizedDescription)
//        }
    }
}
