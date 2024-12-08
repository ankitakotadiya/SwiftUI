import Foundation
import CoreData

protocol ApodDataFetching {
    func fetchApod(for date: String) async -> Apod?
    func saveApod(_ apod: Apod) async
    func fetchLatestApod() async -> Apod?
    func pruneRecordsIfNeeded() async
    func updateElement(for item: Apod?) async
    func fetchFavourites() async -> [Apod]
}

// The `ApodDataBaseService` class provides a centralized way to manage `Apod` data persistence and retrieval from a Core Data database. It simplifies fetching specific or the latest `Apod` entries and ensures efficient saving of new `Apod` data, making it easier to work with local storage in the app.
final class ApodDataBaseService: ApodDataFetching {
    
    private let dataManager: DataBaseManaging
    
    init(dataManager: DataBaseManaging = DataBaseManager(false)) {
        self.dataManager = dataManager
    }
    
    func fetchApod(for date: String) async -> Apod? {
        let predicate = NSPredicate(format: "apodDate == %@", date)
        let descriptors = NSSortDescriptor(key: "date", ascending: false)
        let apodItems: [ItemApod] = await dataManager.fetchRequest(FetchQuery(predicate: predicate, sortDescriptor: [descriptors], fetchLimit: 1, fetchOffset: nil))
        
        return apodItems.first?.toModel()
    }
    
    func saveApod(_ apod: Apod) async {
        _ = ItemApod(context: dataManager.viewContext, item: apod)
        await dataManager.saveContext()
//        do {
//            try await dataManager.saveContext()
//        } catch let error {
//            throw error
//        }
    }
    
    func updateElement(for item: Apod?) async {
        guard let item = item else {return}
        
        let predicate = NSPredicate(format: "apodDate == %@", item.date)
        let descriptors = NSSortDescriptor(key: "date", ascending: false)
        let apodItem: ItemApod? = await dataManager.fetchRequest(FetchQuery(predicate: predicate, sortDescriptor: [descriptors], fetchLimit: 1, fetchOffset: nil)).first
        
        apodItem?.isFavourite = item.isFavourite
//        apodItem?.isMigrationTest = "Test"
        await dataManager.saveContext()
    }
    
    func fetchFavourites() async -> [Apod] {
        let predicate = NSPredicate(format: "isFavourite == %@", NSNumber(booleanLiteral: true))
        let descriptors = NSSortDescriptor(key: "apodDate", ascending: false)
        let apodItem: [ItemApod] = await dataManager.fetchRequest(FetchQuery(predicate: predicate, sortDescriptor: [descriptors], fetchOffset: nil))
        return apodItem.map({$0.toModel()})
    }
    
    func fetchLatestApod() async -> Apod? {
        let descriptors = NSSortDescriptor(key: "date", ascending: false)
        let apodItems: [ItemApod] = await dataManager.fetchRequest(FetchQuery(sortDescriptor: [descriptors], fetchLimit: 1))
        
        return apodItems.first?.toModel() ?? Apod.dummyObj
    }
    
    func pruneRecordsIfNeeded() async {
        let descriptors = NSSortDescriptor(key: "date", ascending: false)
        let query = FetchQuery(sortDescriptor: [descriptors], fetchLimit: 0, fetchOffset: 10)
        await dataManager.pruneOldRecords(query, entity: ItemApod.self)
    }
    
}
