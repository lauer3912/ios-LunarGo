import XCTest

final class LunarGoUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.exists)
    }

    func testTabBarNavigation() throws {
        let app = XCUIApplication()
        app.launch()

        // Test tab bar exists
        XCTAssertTrue(app.tabBars.firstMatch.exists)

        // Test tab navigation
        let tabButtons = app.tabBars.buttons
        XCTAssertGreaterThanOrEqual(tabButtons.count, 4)
    }

    func testHomeScreenLoad() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify Home tab is selected by default
        XCTAssertTrue(app.navigationBars["Home"].exists || app.staticTexts["Your Cosmic Card"].exists)
    }
}