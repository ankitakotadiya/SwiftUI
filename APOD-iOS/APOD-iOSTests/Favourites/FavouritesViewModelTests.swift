import XCTest
@testable import APOD_iOS

final class FavouritesViewModelTests: XCTestCase {

    var databaseManager = MockApodDataBaseService()
    var viewModel: FavouritesViewModel!
    
    // Prepare Viewmodel
    private func prepareViewModel() -> FavouritesViewModel {
        return FavouritesViewModel(dataRepo: databaseManager)
    }
    
    // Setup ViewModel
    override func setUpWithError() throws {
        viewModel = prepareViewModel()
    }
    
    func test_data_received() async {
        await viewModel.fetchList()
        
        let cancellable = viewModel.$state.sink { state in
            if case .loaded(let items) = state {
                XCTAssertEqual(items, Apod.favourites)
            }
        }
        
        cancellable.cancel()
    }
    
    // Favourites Expected Data
    private var expectedData: [FavouritesViewModel.FavouriteSections] {
        return [
            FavouritesViewModel.FavouriteSections(title: Constants.Dates.testDate, rows: Apod.favourites)
        ]
    }
    
    func test_groupped_favourites() async {
        await viewModel.fetchList()
        
        let cancellable = viewModel.$groups.sink { [weak self] sections in
            XCTAssertEqual(self?.expectedData.first?.rows, sections.first?.rows)
        }
        
        cancellable.cancel()
    }
    
    func test_search_feature() async {
        let expectation = self.expectation(description: "Search Result Should Received.")
        
        viewModel.searchText()
        await viewModel.fetchList()
        viewModel.searchTerm = "Test"
        
        if case .loaded(let items) = viewModel.state {
            expectation.fulfill()
            XCTAssertEqual(Apod.favourites, items)
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func test_toggle_favourite() async {
        guard let item = Apod.favourites.first else {return}
        XCTAssertEqual(item.isFavourite, true)
        
        // Test Favourite is toggled
        await viewModel.toggleFavourite(for: item, index: 0)
        await viewModel.fetchList()
        
        let cancellable = viewModel.$state.sink { state in
            if case .loaded(let items) = state {
                XCTAssertEqual(items.count, 0)
            }
        }
        
        cancellable.cancel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
}
