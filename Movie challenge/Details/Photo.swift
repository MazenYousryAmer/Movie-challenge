//
//  PhotoModel.swift
//  Movie challenge
//
//  Created by Mazen on 9/24/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class Photo: NSObject , Codable {

    var id : String = ""
    var owner : String = ""
    var secret : String = ""
    var server: String = ""
    var farm : Int = 0
    var title : String = ""
    var ispublic : Int = 0
    var isfriend : Int = 0
    var isfamily : Int = 0
    
    func getPhotoURL() -> String {
        return "http://farm​\(farm).static.flickr.com/​\(server)/​\(id)_​\(secret).jpg"
//        return URL(string: str)!
    }

}
