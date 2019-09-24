//
//  Movies.swift
//  Movie challenge
//
//  Created by Mazen on 9/20/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class Movie: NSObject , Codable {

    var title : String = ""
    var year : Int = 0
    var cast : [String]? = []
    var genres : [String]? = []
    var rating : Int = 0
}

class Movies: NSObject , Codable {
    
    var movies : [Movie] = []
}
