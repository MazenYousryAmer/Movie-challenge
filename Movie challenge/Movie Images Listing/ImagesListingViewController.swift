//
//  ImagesListingViewController.swift
//  Movie challenge
//
//  Created by Mazen on 9/25/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class ImagesListingViewController: UIViewController {

    //MARK: - iboutels
    @IBOutlet var collectionImages : UICollectionView!
    
    //MARK: - variable
    var presenter : ImagesListingPresenter = ImagesListingPresenter()
    
    //MARK: - view methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    //MARK: - setup
    func setup() {
        setupPresenter()
    }
    
    func setupPresenter() {
        presenter.listingDelegate = self
    }
    
}

extension ImagesListingViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        cell.lblGalleryTitle.text = presenter.allPhotos[indexPath.row].title
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if indexPath.row == presenter.allPhotos.count - 4 {
                presenter.getMoviePhotos()
            }
        }
    
}

extension ImagesListingViewController : ImagesListingProtocol {
    func reloadMovieGallery() {
        collectionImages.reloadData()
    }
}
