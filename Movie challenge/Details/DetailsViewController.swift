//
//  DetailsViewController.swift
//  Movie challenge
//
//  Created by Mazen on 9/22/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    //MARK: - iboutlets
    @IBOutlet var lblName :UILabel!
    @IBOutlet var lblYear :UILabel!
    
    @IBOutlet var tableGenres :UITableView!
    @IBOutlet var heightConstraintGenresView : NSLayoutConstraint!
    @IBOutlet var topConstraintGenresView : NSLayoutConstraint!
    
    @IBOutlet var tableCast :UITableView!
    @IBOutlet var heightConstraintCastView : NSLayoutConstraint!
    @IBOutlet var topConstraintCastView : NSLayoutConstraint!
    
    @IBOutlet var collectionGallery : UICollectionView!
    @IBOutlet var heightConstraintGalleryView : NSLayoutConstraint!
    
    //MARK: - variables
    var presenter : DetailsPresenter = DetailsPresenter()
    
    //MARK: - view methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    //MARK: - setup
    func setup() {
        setupPresenter()
        setupMovieDetails()
        presenter.getMoviePhotos()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
//            self.presenter.getMoviePhotos()
//        })
        
    }
    
    func setupPresenter() {
        presenter.movieDetailsDelegate = self
    }
    
    func setupMovieDetails() {
        lblName.text = presenter.movie.title
        lblYear.text = "\(presenter.movie.year)"
        
        // configure genres height
        if presenter.movie.genres?.count ?? 0 == 0 {
            heightConstraintGenresView.constant = 0.0
            topConstraintGenresView.constant = 0.0
        }
        else {
            // table cell height * count + title and padding
            heightConstraintGenresView.constant = (CGFloat(presenter.movie.genres!.count) * kMovieDetailsHeight) + 41.0
            topConstraintGenresView.constant = 10.0
        }
        
        // configure cast height
        if presenter.movie.cast?.count ?? 0 == 0 {
            heightConstraintCastView.constant = 0.0
            topConstraintCastView.constant = 0.0
        }
        else {
            // table cell height * count + title and padding
            heightConstraintCastView.constant = (CGFloat(presenter.movie.cast!.count) * kMovieDetailsHeight) + 41.0
            topConstraintCastView.constant = 10.0
        }
    }
    
    func setupGallery() {
        
        guard var galleryRownsCount = presenter.allPhotos.count / 2 as? Int else {
            return
        }
        
        if presenter.allPhotos.count % 2 == 1 {
            galleryRownsCount += 1
        }
        
        heightConstraintGalleryView.constant = (CGFloat(galleryRownsCount) * kGalleryPhotoHeight) + CGFloat(galleryRownsCount - 1) * kGalleryPhotoVerticalSpacing
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionGallery.layoutIfNeeded()
        }, completion: { _ in
            self.collectionGallery.reloadData()
        })
        
    }


}

extension DetailsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableGenres {
            return presenter.movie.genres?.count ?? 0
        }
        return presenter.movie.cast?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailedTableViewCell") as! MovieDetailedTableViewCell
        if tableView == tableGenres {
            cell.lblMovieInfo.text = presenter.movie.genres?[indexPath.row] ?? ""
        }
        else if tableView == tableCast {
            cell.lblMovieInfo.text = presenter.movie.cast?[indexPath.row] ?? ""
        }
        return cell
    }
    
}

extension DetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
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
            self.presenter.getMoviePhotos()
        }
    }
    
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.allPhotos.count - 4 {
            print("page Here")
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionGallery.visibleCells {
            let indexPath = collectionGallery.indexPath(for: cell)
            print(indexPath)
        }
    }
    */
    
    
    
}

extension DetailsViewController : DetailsProtocol {
    func reloadGallery() {
        setupGallery()
    }
    
    
}
