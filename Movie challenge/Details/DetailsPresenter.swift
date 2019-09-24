//
//  DetailsPresenter.swift
//  Movie challenge
//
//  Created by Mazen on 9/22/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class DetailsPresenter: NSObject {

    //MARK: - variable
    var movie : Movie!
    weak var detailsVC : DetailsViewController?
    var flickrService : FlickrService = FlickrService()
    var currentPageNumber = 1
    var allPhotos : [Photo] = []
    var canGetNextPage = true
    
    //MARK: - service
    func getMoviePhotos() {
        flickrService.getFlickrMovieImages(movieTitle: movie.title, currentPage: currentPageNumber, onSuccess: { [weak self] photos in
            if photos.count > 0 {
                if photos.count == 10 {
                    self?.canGetNextPage = true
                }
                else {
                    self?.canGetNextPage = false
                }
                self?.allPhotos.append(contentsOf: photos)
                self?.currentPageNumber += 1
//                print(self?.allPhotos.count)
                let x = self?.allPhotos.last
//                print(x?.getPhotoURL())
            }
            else {
                self?.canGetNextPage = false
            }
            
            }, onFailure: { error in
                print(error)
                
        })
    }
}