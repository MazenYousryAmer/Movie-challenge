//
//  Photos.swift
//  Movie challenge
//
//  Created by Mazen on 9/24/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class Photos: NSObject , Codable{

    var page : Int?
    var pages : Int?
    var perpage : Int?
    var total : String?
    var photo : [Photo]? = []
}
