import XCTest
@testable import APOD_iOS

final class ApodListViewModelTests: XCTestCase {
    
    var networkManager = MockApodService()
    var viewModel: ApodListViewModel!
    
    private func prepareviewModel() -> ApodListViewModel {
        return ApodListViewModel(apodService: networkManager)
    }

    override func setUpWithError() throws {
        viewModel = prepareviewModel()
    }
    
    func test_initial_loading_state() {
        XCTAssertEqual(viewModel.state, .loading)
    }
    
    private let expecteddata: [Apod] = {
        [Apod.testValue]
    }()
    
    func test_get_list_success() async {
        await viewModel.getList()
        
        let cancellable = viewModel.$state.sink { state in
            XCTAssertEqual(state.apodList, self.expecteddata)
//            if case .loaded(let list) = state {
//                XCTAssertEqual(self.expecteddata, list)
//            }
        }
        
        cancellable.cancel()
    }
    
    func test_get_list_error() async {
        networkManager.isError = true
        await viewModel.getList()
        
        let cancellable = viewModel.$state.sink { state in
            XCTAssertEqual(state.erroString, AppError.NetworkManagerError(.networkError).localizedDescription)
//            if case .error(let string) = state {
//                XCTAssertEqual(AppError.NetworkManagerError(.networkError).localizedDescription, string)
//            }
        }
        
        cancellable.cancel()
    }
    

    override func tearDownWithError() throws {
        viewModel = nil
    }

}
