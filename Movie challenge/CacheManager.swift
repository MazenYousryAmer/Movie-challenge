//
//  CacheManager.swift
//  Movie challenge
//
//  Created by Mazen on 9/26/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class CacheManager  {
    
    
        static func saveMovies(movies: Movies) {
            let data = NSKeyedArchiver.archivedData(withRootObject: movies)
            UserDefaults.standard.set(data, forKey: "movies")
        }
        
        static func loadMovies() -> Movies?  {
            let data = UserDefaults.standard.data(forKey: "movies")
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? Movies
    }
}
