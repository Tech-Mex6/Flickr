//
//  FlickrUITests.swift
//  FlickrUITests
//
//  Created by meekam okeke on 2/5/25.
//

import XCTest
@testable import Flickr

final class FlickrUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchUpdatesResults() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search field should exist")
        
        searchField.tap()
        searchField.typeText("landscape")
        let firstCell = app.collectionViews.cells.firstMatch
                XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "Images should load after search")
    }
}
