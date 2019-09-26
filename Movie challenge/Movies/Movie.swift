//
//  Movies.swift
//  Movie challenge
//
//  Created by Mazen on 9/20/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class Movie: NSObject , Codable , NSCoding {

    var title : String = ""
    var year : Int = 0
    var cast : [String]? = []
    var genres : [String]? = []
    var rating : Int = 0
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title , forKey: "title")
        aCoder.encode(self.year , forKey: "year")
        aCoder.encode(self.cast , forKey: "cast")
        aCoder.encode(self.genres , forKey: "genres")
        aCoder.encode(self.rating , forKey: "rating")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.title = aDecoder.decodeObject(forKey: "title") as! String
//        self.year = aDecoder.decodeObject(forKey: "year") as? Int ?? 0
        self.year = aDecoder.decodeInteger(forKey: "year")
        self.cast = aDecoder.decodeObject(forKey: "cast") as? [String]
        self.genres = aDecoder.decodeObject(forKey: "genres") as? [String]
        self.rating = aDecoder.decodeInteger(forKey: "rating")
    }
}

class Movies: NSObject , Codable , NSCoding {
    
    var movies : [Movie] = []
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.movies , forKey: "movies")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.movies =  aDecoder.decodeObject(forKey: "movies") as! [Movie]
    }
    
    override init() {
        
    }
}
