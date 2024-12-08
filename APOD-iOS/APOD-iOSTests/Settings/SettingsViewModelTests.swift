import XCTest
@testable import APOD_iOS

final class SettingsViewModelTests: XCTestCase {

    var viewModel: SettingsViewModel!
    
    override func setUpWithError() throws {
//        viewModel = SettingsViewModel()
    }
    
    func test_set_data() {
        viewModel = SettingsViewModel()
        
        let cancellable = viewModel.$sectioData.sink { sections in
            XCTAssertEqual(sections.count, 3)
        }
        
        cancellable.cancel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

}
