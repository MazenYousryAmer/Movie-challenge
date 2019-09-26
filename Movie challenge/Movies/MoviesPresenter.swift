//
//  MoviesPresenter.swift
//  Movie challenge
//
//  Created by Mazen on 9/20/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

protocol MoviesProtocol : class {
    func reloadMovies()
    func showMoviesLoadingError()
}

class MoviesPresenter: NSObject {

    //MARK: - variable
    var movieService : MoviesService = MoviesService()
    var allMovies : Movies!
    var formatedArrMovies : [[Movie]] = []
    var filteredMovies : [[Movie]] = []
    var isSearching = false
    weak var moviesDelegate : MoviesProtocol?
    
    //MARK: - service
    func getAllMovies() {
        // get all movies from file
        movieService.getAllMovies(onSuccess: {[weak self] movies in
            self?.allMovies = movies
            self?.formatedArrMovies = self?.formateMovies(movies) ?? []
            self?.formatedArrMovies = self?.sortFormatedMoviesByRating() ?? []
            self?.filteredMovies = self?.formatedArrMovies ?? []
            }, onFailure: { [weak self] error in
                self?.moviesDelegate?.showMoviesLoadingError()
                print("error")
        })
    }
    
    //MARK: - model formatting
    func formateMovies(_ movies : Movies) -> [[Movie]] {
        // format movies to fit in 2D array for table view
        
        // grouping movies by year to sort easier
        var formatedMovies : [String : [Movie]] = [:]
        for movie in movies.movies {
            if formatedMovies.keys.contains(String(movie.year)) {
                formatedMovies[String(movie.year)]?.append(movie)
            }
            else {
                formatedMovies[String(movie.year)] = [movie]
            }
        }

        // soring grouped movies by year descending order
        var tempFormattingArray : [[Movie]] = []
        for year in formatedMovies.keys.sorted().reversed() {
            tempFormattingArray.append(formatedMovies[year]!)
        }
        return tempFormattingArray
    }
    
    func sortFormatedMoviesByRating() -> [[Movie]] {
        for (index, var MoviesOfYear) in formatedArrMovies.enumerated() {
            for _ in MoviesOfYear {
                MoviesOfYear = MoviesOfYear.sorted(by: { $0.rating > $1.rating })
            }
            formatedArrMovies[index] = MoviesOfYear
        }
        return formatedArrMovies
    }
    
    //MARK: - search
    func cancelSearchHandler() {
        // handle cancel saerch action
        resetSearch()
        moviesDelegate?.reloadMovies()
    }
    
    func titleSearchHandler(_ searchText : String) {
        // handle search by movie title
        resetSearch()
        
//        let array = ["A", "B", "C"]
//        let arraySlice = array.prefix(upTo: 5)
//        let newArray = Array(arraySlice)
//        print(newArray) // prints: ["A", "B", "C", "D", "E"]
        
        // search by title
        for (index,arr) in filteredMovies.enumerated() {
            let filteredYear = arr.filter({
                $0.title.contains(searchText)
            })
            
//            if filteredYear.count > 5 {
//                let arraySlice = filteredYear.prefix(5)
//                filteredYear = Array(arraySlice)
//            }
            
            filteredMovies[index] = filteredYear
        }
        
        // remove empty years
        filteredMovies.removeAll(where: {
            $0.count == 0
        })
        
        moviesDelegate?.reloadMovies()
    }
    
    func castSearchHandler(_ searchText : String) {
        // handle search by actor name
        resetSearch()
        
        // search by title
        for (index,arr) in filteredMovies.enumerated() {
            let filteredYear = arr.filter({
                $0.cast?.contains(searchText) ?? false
            })
            
            filteredMovies[index] = filteredYear
        }
        
        // remove empty years
        filteredMovies.removeAll(where: {
            $0.count == 0
        })
        
        moviesDelegate?.reloadMovies()
    }
    
    func resetSearch() {
        // remove filters and put back original formated movies
        filteredMovies = formatedArrMovies
//        isSearching = false
    }
}
