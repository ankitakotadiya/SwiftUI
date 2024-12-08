import XCTest

final class SettingsViewTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launch()
    }
    
    func test_apod_plus_section() {
        settingsTab()
        
        // Navigation Bar
        let navBar = app.navigationBars["Settings"]
        XCTAssertTrue(navBar.exists)
        
        // List
        XCTAssertTrue(list.waitForExistence(timeout: 1))
        
        let apodPlus = list.firstMatch
        let headerTitle = apodPlus.staticTexts["APOD PLUS"]
        XCTAssertTrue(headerTitle.exists)
        
        let upgradeView = apodPlus.staticTexts["View Upgrades"]
        XCTAssertTrue(upgradeView.exists)
        
        upgradeView.tap()
        
        let upgradeTitle = app.staticTexts["Upgrades"]
        XCTAssertTrue(upgradeTitle.waitForExistence(timeout: 2.0))
    }
    
    func test_about_section() {
        settingsTab()
        
        // About Section
        XCTAssertTrue(list.exists)
        
        let share = list.children(matching: .cell).element(boundBy: 4)
        XCTAssertTrue(share.exists)
        
        share.tap()
        
        let sharelink = app.collectionViews.containing(.cell, identifier:"Copy").element
        sharelink.tap()
    }
    
    func test_privacy_policy() {
        settingsTab()
        
        let privacy = list.children(matching: .cell).element(boundBy: 7)
        XCTAssertTrue(privacy.exists)
        
        privacy.tap()
        
        let safariApplication = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        _ = safariApplication.wait(for: .runningForeground, timeout: 2)
        
        app.activate()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    private var list: XCUIElement {
        app.collectionViews["SettingsList"]
    }
    
    private func settingsTab() {
        let tabbar = app.tabBars
        
        // Settings tab
        let settings = tabbar.buttons["Settings"]
        settings.tap()

    }
}
