//
//  Movie_challengeTests.swift
//  Movie challengeTests
//
//  Created by Mazen on 9/20/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import XCTest
@testable import Movie_challenge

class MoviesPresenterTests: XCTestCase {

    var presenter : MoviesPresenter?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        presenter = MoviesPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        super.tearDown()
    }
    
    func getMovies() -> Movies {
        if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let moviesData = jsonResult["movies"] as? [Dictionary<String, AnyObject>] {
                    let movies = try! JSONDecoder().decode(Movies.self, from: data)
                    return movies
                }
            } catch {
                return Movies()
            }
        }
        return Movies()
    }
    
    func testGetAllMovies() {
        
        // given
        presenter?.movieService = MoviesService()
        presenter?.allMovies = Movies()
        let expectation = self.expectation(description: "get movies")
        
        // when
        presenter?.movieService.getAllMovies(onSuccess: {[weak self] movies in
            self?.presenter?.allMovies = movies
            expectation.fulfill()
        }, onFailure: { _ in
            expectation.isInverted = true
        })
        
        // then
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertTrue(presenter?.allMovies.movies.count ?? 0 > 0, "No Movies")
    }
    
    func testFormateMovies() {
        
        // given
        presenter?.allMovies = getMovies()
        
        // when
        let arr = presenter?.formateMovies(presenter?.allMovies ?? Movies())
        
        // then
        XCTAssertTrue(arr?.count == 10, "arr should have movies of 10 years")
    }
    
    func testCancelSearch() {
        // given
        presenter?.allMovies = getMovies()
        presenter?.formatedArrMovies = presenter?.formateMovies(presenter?.allMovies ?? Movies()) ?? []
        presenter?.filteredMovies = []
        
        // when
        presenter?.cancelSearchHandler()
        
        // then
        XCTAssertTrue(presenter?.formatedArrMovies.count == (presenter?.filteredMovies.count)! , "Cancel search is not working and original movies are not restored")
    }
    
    func testTitleSearch() {
        // given
        presenter?.allMovies = getMovies()
        presenter?.formatedArrMovies = presenter?.formateMovies(presenter?.allMovies ?? Movies()) ?? []
        presenter?.cancelSearchHandler()
        
        // when
        presenter?.titleSearchHandler("12 Strong")
        
        // then
        if let moviesOfTheYear = presenter?.filteredMovies[0] {
            if let movie = moviesOfTheYear.first , moviesOfTheYear.count == 1 {
                XCTAssertTrue(movie.title == "12 Strong", "Something wrong with movie title searching")
            }
        }
    }
    
    func testActorSearch() {
        // given
        presenter?.allMovies = getMovies()
        presenter?.formatedArrMovies = presenter?.formateMovies(presenter?.allMovies ?? Movies()) ?? []
        presenter?.cancelSearchHandler()
        
        // when
        presenter?.castSearchHandler("John Cena")
        
        // then
        if let moviesOfTheYear = presenter?.filteredMovies[0] {
            if let movie = moviesOfTheYear.first {
                XCTAssertTrue(movie.title == "Blockers", "Something wrong with movie cast searching")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
