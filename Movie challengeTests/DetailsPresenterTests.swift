//
//  DetailsPresenterTests.swift
//  Movie challengeTests
//
//  Created by Mazen on 9/26/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import XCTest
@testable import Movie_challenge

class DetailsPresenterTests: XCTestCase {

    var presenter : DetailsPresenter?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        presenter = DetailsPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        super.tearDown()
    }
    
    func testGetMoviePhotos() {
        
        // given
        presenter?.flickrService = FlickrService()
        presenter?.movie = Movie()
        presenter?.movie.title = "Winchester"
        presenter?.allPhotos = []
        let expectation = self.expectation(description: "get movie images")
        
        // when
        presenter?.flickrService.getFlickrMovieImages(movieTitle: "Winchester", currentPage: 1, onSuccess: { [weak self] images in
            self?.presenter?.allPhotos = images
            expectation.fulfill()
        }, onFailure: { _ in
            expectation.isInverted
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(presenter?.allPhotos.count == 10  , "unable to fetch movies")
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
