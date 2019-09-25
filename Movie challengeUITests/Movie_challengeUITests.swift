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
    
    func testApp() {
        
        let app = XCUIApplication()
        let movietableTable = app/*@START_MENU_TOKEN@*/.tables["MovieTable"]/*[[".tables[\"2018, Insidious: The Last Key, The Strange Ones, Sweet Country, The Commuter, Proud Mary, Acts of Violence, Freak Show, Humor Me, 12 Strong, Den of Thieves, Forever My Girl, Maze Runner: The Death Cure, The Insult, Please Stand By, Winchester, A Fantastic Woman\"]",".tables[\"MovieTable\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        movietableTable/*@START_MENU_TOKEN@*/.staticTexts["Insidious: The Last Key"]/*[[".cells[\"Insidious: The Last Key\"].staticTexts[\"Insidious: The Last Key\"]",".staticTexts[\"Insidious: The Last Key\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let scrollViewsQuery = app.scrollViews
        let tablesQuery = scrollViewsQuery.otherElements.tables
        let leighWhannellStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Leigh Whannell"]/*[[".cells.staticTexts[\"Leigh Whannell\"]",".staticTexts[\"Leigh Whannell\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        leighWhannellStaticText.swipeUp()
        leighWhannellStaticText.swipeDown()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Lin Shaye"]/*[[".cells.staticTexts[\"Lin Shaye\"]",".staticTexts[\"Lin Shaye\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        let collectionViewsQuery = app/*@START_MENU_TOKEN@*/.collectionViews/*[[".scrollViews.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        collectionViewsQuery.otherElements.containing(.staticText, identifier:"Images :").element.swipeUp()
        collectionViewsQuery.staticTexts["Images :"].swipeUp()
        
        let moviesButton = app.navigationBars["Movie_challenge.DetailsView"].buttons["MOVIES"]
        moviesButton.tap()
        movietableTable/*@START_MENU_TOKEN@*/.staticTexts["Winchester"]/*[[".cells[\"Winchester\"].staticTexts[\"Winchester\"]",".staticTexts[\"Winchester\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Angus Sampson"]/*[[".cells.staticTexts[\"Angus Sampson\"]",".staticTexts[\"Angus Sampson\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Show all images").children(matching: .button).element.tap()
        
        let collectionViewsQuery2 = app.collectionViews
        collectionViewsQuery2/*@START_MENU_TOKEN@*/.staticTexts["29 Winchester (2)"]/*[[".cells.staticTexts[\"29 Winchester (2)\"]",".staticTexts[\"29 Winchester (2)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        collectionViewsQuery2/*@START_MENU_TOKEN@*/.staticTexts["29 Winchester (43)"]/*[[".cells.staticTexts[\"29 Winchester (43)\"]",".staticTexts[\"29 Winchester (43)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        app.navigationBars["Movie_challenge.ImagesListingView"].buttons["Back"].tap()
        moviesButton.tap()
    }

}
