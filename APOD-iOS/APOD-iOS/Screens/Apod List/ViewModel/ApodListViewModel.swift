import Foundation
import Combine

enum ListState: Equatable {
    
    case loading
    case loaded([Apod])
    case error(String?)
    
    var apodList: [Apod] {
        switch self {
        case .loading, .error(_):
            return []
        case .loaded(let array):
            return array
        }
    }
    
    var erroString: String? {
        switch self {
        case .loading, .loaded(_):
            return nil
        case .error(let err):
            return err
        }
    }
}

final class ApodListViewModel: ObservableObject {
    private let apodService: ApodFetching
    private let dateFormatting: DateFormatting
    @Published var startDate: Date = Date.now
    @Published var endDate: Date = Date.now
    @Published var state: ListState = .loading
    private var cancellable = Set<AnyCancellable>()
    
    init(apodService: ApodFetching = DependencyManager.apodService, dateformatting: DateFormatting = DefaultDateFormatter()) {
        self.apodService = apodService
        self.dateFormatting = dateformatting
        setDates()
    }
    
    @MainActor
    func getList() async {
        state = .loading
        do {
            let result = try await apodService.getList(for: ["end_date": dateToString(endDate), "start_date": dateToString(startDate)])
            
            switch result {
            case .success(let apods):
                sortData(apods)
            case .failure(let error):
                state = .error(error.localizedDescription)
            }
        } catch let error {
            state = .error(error.localizedDescription)
        }
    }
    
    private func sortData(_ apods: [Apod]) {
        let sortedApods = apods.sorted { $0.date > $1.date }
        state = .loaded(sortedApods)
    }
    
    private func setDates() {
        $startDate.sink { [weak self] date in
            self?.adjustEndDateIfNeeded(date)
        }.store(in: &cancellable)
    }
    
    private func adjustEndDateIfNeeded(_ newStartDate: Date) {
        if let maxEndDate = calender.date(byAdding: .month, value: 1, to: newStartDate), endDate > maxEndDate {
            endDate = maxEndDate
        }
    }
    
    private var calender: Calendar = {
        return Calendar.current
    }()

    var apodDate: Date {
        self.dateFormatting.dateFromString(Defautls.apodStartDate, dateStyle: .short)
    }
    
    private func dateToString(_ date: Date) -> String {
        dateFormatting.stringFromDate(date: date, dateStyle: .short)
    }
}
