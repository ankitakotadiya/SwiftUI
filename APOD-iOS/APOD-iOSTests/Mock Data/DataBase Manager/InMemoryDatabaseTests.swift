import XCTest
@testable import APOD_iOS

final class InMemoryDatabaseTests: XCTestCase {

    var dataManager: DataBaseManaging!
    
    override func setUpWithError() throws {
        dataManager = DataBaseManager(true)
    }
    
    func test_save_item() async {
        let context = dataManager.viewContext
        _ = ItemApod(context: context, item: Apod.testValue)
        
        await dataManager.saveContext()
        
        let fetchResult: [ItemApod] = await dataManager.fetchRequest(
            FetchQuery(
                predicate: nil,
                fetchLimit: 1
            )
        )
        
        let apodItem = fetchResult.first?.toModel()
        XCTAssertEqual(apodItem, Apod.testValue)
    }

    override func tearDownWithError() throws {
        dataManager = nil
    }
}
