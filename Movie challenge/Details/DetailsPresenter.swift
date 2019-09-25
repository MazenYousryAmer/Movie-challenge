//
//  DetailsPresenter.swift
//  Movie challenge
//
//  Created by Mazen on 9/22/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

protocol DetailsProtocol : class {
    func reloadGallery()
    func showActivityStatus()
}

enum ActivityStatus {
    case loadPhotos
    case errorPhotos
    case showAllPhotos
    case noPhotos
}

class DetailsPresenter: NSObject {

    //MARK: - variable
    var movie : Movie!
    var movieDetailsDelegate : DetailsProtocol?
    var flickrService : FlickrService = FlickrService()
    var currentPageNumber = 1
    var allPhotos : [Photo] = []
    var canGetNextPage = true
    var canFetchData = true
    var status : ActivityStatus = ActivityStatus.loadPhotos {
        didSet {
            DispatchQueue.main.async {
                self.movieDetailsDelegate?.showActivityStatus()
            }
        }
    }
    
    
    //MARK: - service
    func getMoviePhotos() {
        flickrService.getFlickrMovieImages(movieTitle: movie.title, currentPage: currentPageNumber, onSuccess: { [weak self] photos in
            if photos.count > 0 {
                self?.allPhotos.append(contentsOf: photos)
                
                DispatchQueue.main.async {
                    self?.status = .showAllPhotos
                    self?.movieDetailsDelegate?.reloadGallery()
                }
            }
            else {
                self?.status = .noPhotos
            }
            
            }, onFailure: { [weak self] error in
                self?.status = .errorPhotos
                
        })
    }
}
