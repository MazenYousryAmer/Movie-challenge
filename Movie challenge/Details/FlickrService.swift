//
//  FlickrService.swift
//  Movie challenge
//
//  Created by Mazen on 9/24/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class FlickrService: NSObject {

    func getUrlForMovie(_ movieTitle: String , currentPage : Int) -> URL? {
        let urlStr = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(kFlickrKey)&text=\(movieTitle)&per_page=10&page=\(currentPage)&format=json&nojsoncallback=1"
        let encodedURL = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: encodedURL)
    }
    
    func getFlickrMovieImages(movieTitle: String , currentPage : Int , onSuccess: @escaping (([Photo]) -> Void), onFailure: @escaping ((String) -> Void)) {
        guard let url = getUrlForMovie(movieTitle, currentPage: currentPage) else {
            return
        }
        let session = URLSession.shared
        let requestURL = URLRequest(url: url)
        let task = session.dataTask(with: requestURL) { [weak self] data , response , error in
            if error == nil
            {
                if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    let photos = self?.parseDataFromFlickr(data: data)
                    onSuccess(photos ?? [])
                }
                else {
                    onFailure("fail")
                }
            }
            else {
                onFailure("an error has occured")
            }
        }
        task.resume()
    }
    
    func parseDataFromFlickr(data : Data) -> [Photo]? {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let model = try JSONDecoder().decode(FlickrModel.self, from: data)
                return model.photos?.photo
        }
        catch  {
            print(error.localizedDescription)
        }
        
        return []
    }
}
