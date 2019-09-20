//
//  MoviesService.swift
//  Movie challenge
//
//  Created by Mazen on 9/20/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class MoviesService: NSObject {

    func getAllMovies(onSuccess: @escaping ((Movies) -> Void), onFailure: @escaping ((String) -> Void)) {
        
        if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let moviesData = jsonResult["movies"] as? [Dictionary<String, AnyObject>] {
                    let movies = try! JSONDecoder().decode(Movies.self, from: data)
                    onSuccess(movies)
                }
                else {
                    onFailure("error happened")
                }
            } catch {
                // handle error
                onFailure("error happened")
            }
        }
    }
}
