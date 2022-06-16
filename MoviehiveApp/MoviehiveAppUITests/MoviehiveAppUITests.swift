//
//  MoviehiveAppUITests.swift
//  MoviehiveAppUITests
//
//  Created by Zeynep Gizem Gürsoy on 24.04.2022.
//

import XCTest

class MoviehiveAppUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("**** UITests ****")
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testGoToDetail() throws {
        app.launch()
        app.collectionViews["nowPlayingCollectionView"].cells.element(boundBy:0).tap()
        XCTAssertTrue(app.collectionViews["nowPlayingCollectionView"].exists)
        XCTAssertTrue(app.isFavoriteButtonDisplayed)
        app.collectionViews["similarCollectionView"].cells.element(boundBy:0).tap()
        XCTAssertTrue(app.collectionViews["similarCollectionView"].exists)
        let backButton = app.navigationBars["Moviehive"].buttons["Back"]
        backButton.tap()
        let moviehiveNavigationBar = app.navigationBars["Moviehive"]
        moviehiveNavigationBar.buttons["Moviehive"].tap()
        
    }
    func testSearch() throws {
        
        app.launch()
        let searchSearchField = app.searchFields["Search"]
        searchSearchField.tap()
        XCTAssertTrue(searchSearchField.exists)
        searchSearchField.typeText("The")
        app/*@START_MENU_TOKEN@*/.tables["Search results"].staticTexts["The Batman"]/*[[".otherElements[\"Double-tap to dismiss\"].tables[\"Search results\"]",".cells.staticTexts[\"The Batman\"]",".staticTexts[\"The Batman\"]",".tables[\"Search results\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.isFavoriteButtonDisplayed)
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["favoriteButton"]/*[[".buttons[\"love\"]",".buttons[\"favoriteButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let moviehiveNavigationBar = app.navigationBars["Moviehive"]
        moviehiveNavigationBar.buttons["Moviehive"].tap()
        searchSearchField.buttons["Clear text"].tap()

    }
    func testFavorite() throws {
        
        app.launch()
        
        app.collectionViews["upcomingCollectionView"].cells.element(boundBy:0).tap()
        XCTAssertTrue(app.collectionViews["upcomingCollectionView"].exists)
        XCTAssertTrue(app.isFavoriteButtonDisplayed)
        let loveButton = app.scrollViews.otherElements.buttons["love"]
        
        loveButton.tap()
       // XCTAssertTrue(loveButton.isSelected)
        loveButton.tap()
        app.navigationBars["Moviehive"].buttons["Moviehive"].tap()
       
    }
}
extension XCUIApplication {
    var upcomingCollectionView: XCUIElement! {
        //collectionViews.element(matching: .collectionView, identifier: "upcomingCollectionView")
        collectionViews["upcomingCollectionView"]
    }
    var nowPlayingCollectionView: XCUIElement! {
        //collectionViews.element(matching: .collectionView, identifier: "nowPlayingCollectionView")
        collectionViews["nowPlayingCollectionView"]
    }
    var favoriteButton: XCUIElement! {
        buttons["favoriteButton"]
    }
    var movieNameLabel: XCUIElement! {
        staticTexts.matching(identifier: "movieNameLabel").element
    }
    
    var isUpcomingCollectionViewDisplayed: Bool {
        upcomingCollectionView.exists
    }
    var isNowPlayingCollectionViewDisplayed: Bool {
        nowPlayingCollectionView.exists
    }
    var isFavoriteButtonDisplayed: Bool {
        favoriteButton.exists
    }

}
