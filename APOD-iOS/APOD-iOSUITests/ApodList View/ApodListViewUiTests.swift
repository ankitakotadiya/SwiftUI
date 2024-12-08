import XCTest
@testable import APOD_iOS

final class ApodListViewUiTests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launch()

    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_apod_list_flow() {
        // Tabbar
        let tabbar = app.tabBars
        
        // Apolist tab
        let apodList = tabbar.buttons["Apod List"]
        XCTAssertTrue(apodList.exists)
        
        apodList.tap()
        
        // Apod List navigation bar
        let list = app.collectionViews["ApodList"]
        XCTAssertTrue(list.waitForExistence(timeout: 2.0))
        
        let explanationLabel = list.firstMatch.staticTexts["ExplanationLabel"]
        XCTAssertTrue(explanationLabel.exists)
        
        // Datepicker
        let datepicker = app.datePickers["ApodListDatePicker"]
        XCTAssertTrue(datepicker.waitForExistence(timeout: 2.0))
        
        datepicker.tap()
        
        app.tap()
    }

}
