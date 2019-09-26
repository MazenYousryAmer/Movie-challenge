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

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAppFlow() {
        
        let app = XCUIApplication()
        let movietableTable = app.tables
        movietableTable.staticTexts["The Strange Ones"].tap()
        let scrollViewsQuery = app.scrollViews
        let tablesQuery = scrollViewsQuery.otherElements.tables
        let leighWhannellStaticText = tablesQuery.staticTexts["Emily Althaus"]
        leighWhannellStaticText.swipeUp()
        leighWhannellStaticText.swipeDown()
        tablesQuery.staticTexts["Alex Pettyfer"].swipeUp()
        let collectionViewsQuery = app/*@START_MENU_TOKEN@*/.collectionViews/*[[".scrollViews.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        collectionViewsQuery.otherElements.containing(.staticText, identifier:"Images :").element.swipeUp()
        let moviesButton = app.navigationBars["Movie_challenge.DetailsView"].buttons["MOVIES"]
        moviesButton.tap()
        movietableTable.staticTexts["Beirut"].tap()
        tablesQuery.staticTexts["Mark Pellegrino"].swipeUp()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Show all images").children(matching: .button).element.tap()
        let collectionViewsQuery2 = app.collectionViews
        collectionViewsQuery2.staticTexts["XNM 05"].swipeUp()
        collectionViewsQuery2.staticTexts["IMGL97557"].swipeDown()
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
