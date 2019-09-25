//
//  ImagesListingPresenter.swift
//  Movie challenge
//
//  Created by Mazen on 9/25/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

protocol ImagesListingProtocol {
    func reloadMovieGallery()
}

class ImagesListingPresenter: NSObject {

    var movie : Movie!
    var allPhotos : [Photo] = []
    var listingDelegate : ImagesListingProtocol!
    var flickrService : FlickrService = FlickrService()
    var currentPageNumber = 2
    
    //MARK: - service
    func getMoviePhotos() {
//        if !canFetchData {
//            return
//        }
        
//        canFetchData = false
        flickrService.getFlickrMovieImages(movieTitle: movie.title, currentPage: currentPageNumber, onSuccess: { [weak self] photos in
//            self?.canFetchData = true
            if photos.count > 0 {
                if photos.count == 10 {
//                    self?.canGetNextPage = true
                }
                else {
//                    self?.canGetNextPage = false
                }
                self?.allPhotos.append(contentsOf: photos)
                self?.currentPageNumber += 1
                
                DispatchQueue.main.async {
                    self?.listingDelegate.reloadMovieGallery()
                }
                //                print(self?.allPhotos.count)
                //                let x = self?.allPhotos.last
                //                print(x?.getPhotoURL())
            }
            else {
//                self?.canGetNextPage = false
            }
            
            }, onFailure: { error in
                print(error.description)
        })
    }
}
