import XCTest
@testable import APOD_iOS

final class ApodViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment["ui_test_media"] = "image"
        
        // Launch App
        
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_progress_view() {
        app.launch()
        // Wait for the image loading indicator to appear
        let imageIndicator = app.activityIndicators["MainLoadingIndicator"]
        XCTAssertNotNil(imageIndicator)

        // Wait for it to disappear
        let disappears = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: imageIndicator
        )
        let result = XCTWaiter().wait(for: [disappears], timeout: 5)
        XCTAssertEqual(result, .completed, "Image loading indicator should disappear after loading.")
    }
    
    func test_app_flow() {
        app.launch()
        // Navigation Bar
        let navBar = app.navigationBars["APOD"]
        XCTAssertTrue(navBar.exists)
        
        // Tabbar
        let tabBar = app.tabBars
            
        // Today tab is selected
        let today = tabBar.buttons["Today"]
        XCTAssertTrue(today.isSelected)
        
        // Favourites is selected
        let favourites = tabBar.buttons["Favourites"]
        favourites.tap()
        XCTAssertTrue(favourites.isSelected)
        
        // Favourites view is loaded
        let favNavbar = app.navigationBars["Favourites"]
        XCTAssertTrue(favNavbar.exists)
        
        // Back to Today tab
        today.tap()
        
        // DatePicker
        let datePicker = app.datePickers["DatePicker"]
        XCTAssertTrue(datePicker.exists)
        
        // DatePicker clicks
        datepickerClicks()
        
        // Image Loaded
        let mediaContent = app.images["MediaContentView"]
        XCTAssertTrue(mediaContent.exists, "Media content area should exist.")
        
        // Image Downloading Failed
//        let failedImage = app.images["exclamationmark.triangle"]
//        XCTAssertTrue(failedImage.exists)
        
        // Title Label
        let tileLabel = app.staticTexts["Test Title"]
        XCTAssertTrue(tileLabel.waitForExistence(timeout: 2.0))
        
        // Title Label
        let description = app.staticTexts["Test Explanation"]
        XCTAssertTrue(description.waitForExistence(timeout: 2.0))
    }
    
    func test_video() {
        app.launchEnvironment["ui_test_media"] = "video"
        app.launch()
        
        let description = app.staticTexts["Test Video Title"]
        XCTAssertTrue(description.waitForExistence(timeout: 5.0))
    }
}

extension ApodViewUITests {
    private func datepickerClicks() {
        // DatePicker
        let datePicker = app.datePickers["DatePicker"]
        XCTAssertTrue(datePicker.exists)
        
        datePicker.tap()
        
        // Close picker
        app.tap()
    }
}
