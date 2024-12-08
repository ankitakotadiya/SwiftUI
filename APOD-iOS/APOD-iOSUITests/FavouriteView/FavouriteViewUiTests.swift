import XCTest
@testable import APOD_iOS

final class FavouriteViewUiTests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        
        // Launch app
        app.launch()
    }
    
    func test_favorite_flow() {
        // Tabbar
        let tabbar = app.tabBars
        
        // Favoutite tab tapped
        let favTab = tabbar.buttons["Favourites"]
        favTab.tap()
        
        // Favourite tab is selected
//        XCTAssertTrue(favTab.isSelected)
        
        // Favourite Navigation Bar
        let navBar = app.navigationBars["Favourites"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 1.0))
        
        let list = app.scrollViews.firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 1.0))
        
        // Test Content
        let rowTitle = list.staticTexts["Test Favourite Item"]
        XCTAssertTrue(rowTitle.waitForExistence(timeout: 1.0))
        
        list.tap()
        
        // First Tap is selected
        let apodNavBar = app.navigationBars["APOD"]
        XCTAssertTrue(apodNavBar.waitForExistence(timeout: 2.0))
    }
    
    func test_search_flow() {
        // Tap favourite
        let fav = app.tabBars.buttons["Favourites"]
        fav.tap()
        
        // Searchbar
        let searchField = app.searchFields["Search"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 1.0))
        
        // Tap on searchbar
        searchField.tap()
        
        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 1.0))
        
        searchField.typeText("Test")
        
        // Data Exist
        let listItem = app.scrollViews.staticTexts["Test Favourite Item"]
        XCTAssertTrue(listItem.waitForExistence(timeout: 2.0))
        
        cancelButton.tap()
        
        // Test no data
        searchField.tap()
        searchField.typeText("Random Text")
        
        // No Favourites exists
        let nofav = app.staticTexts["No favourites yet."]
        XCTAssertTrue(nofav.waitForExistence(timeout: 3.0))
    }

    override func tearDownWithError() throws {
        app = nil
    }

}
