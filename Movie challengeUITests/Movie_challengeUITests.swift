//
//  Movie_challengeUITests.swift
//  Movie challengeUITests
//
//  Created by Mazen on 9/20/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import XCTest

class Movie_challengeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAppFlow() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["The Strange Ones"]/*[[".cells[\"The Strange Ones\"].staticTexts[\"The Strange Ones\"]",".staticTexts[\"The Strange Ones\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let collectionViewsQuery = app/*@START_MENU_TOKEN@*/.collectionViews/*[[".scrollViews.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.tables/*@START_MENU_TOKEN@*/.staticTexts["Tobias Campbell"]/*[[".cells.staticTexts[\"Tobias Campbell\"]",".staticTexts[\"Tobias Campbell\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        let moviesButton = app.navigationBars["Movie_challenge.DetailsView"].buttons["MOVIES"]
        moviesButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Beirut"]/*[[".cells[\"Beirut\"].staticTexts[\"Beirut\"]",".staticTexts[\"Beirut\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.staticTexts["Mark Pellegrino"].swipeUp()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Show all images").children(matching: .button).element.tap()
        app.navigationBars["Movie_challenge.ImagesListingView"].buttons["Back"].tap()
        moviesButton.tap()
        
    }
    
    func testSearch() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let searchHereSearchField = tablesQuery.searchFields["Search here"]
        searchHereSearchField.tap()
        searchHereSearchField.typeText("12 Strong")
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["12 Strong"]/*[[".cells[\"12 Strong\"].staticTexts[\"12 Strong\"]",".cells[\"cell\"].staticTexts[\"12 Strong\"]",".staticTexts[\"12 Strong\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let moviesButton = app.navigationBars["Movie_challenge.DetailsView"].buttons["MOVIES"]
        moviesButton.tap()
        let clearTextButton = tablesQuery.buttons["Clear text"]
        clearTextButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Actor"]/*[[".segmentedControls.buttons[\"Actor\"]",".buttons[\"Actor\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchHereSearchField.typeText("John Cena")
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Daddy's Home 2"]/*[[".cells[\"Daddy's Home 2\"].staticTexts[\"Daddy's Home 2\"]",".staticTexts[\"Daddy's Home 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        moviesButton.tap()
        clearTextButton.tap()
    }

}
