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
    
    @IBOutlet var lblActivity :UILabel!
    @IBOutlet var btnActivity :UIButton!
    @IBOutlet var loadingIndicator : UIActivityIndicatorView!
    
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
        presenter.status = ActivityStatus.loadPhotos
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
        
        // cell height * count + spacing height * number of spaces + header height
        heightConstraintGalleryView.constant = (CGFloat(galleryRownsCount) * kGalleryPhotoHeight) + CGFloat(galleryRownsCount - 1) * kGalleryPhotoVerticalSpacing + kcollectionHeaderHeight
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionGallery.layoutIfNeeded()
        }, completion: { _ in
            self.collectionGallery.reloadData()
        })
    }
    
    func setupActivityStatusView() {
        switch presenter.status {
        case .loadPhotos:
            lblActivity.isHidden = true
            btnActivity.isHidden = true
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            
        case .errorPhotos:
            lblActivity.isHidden = false
            btnActivity.isHidden = false
            loadingIndicator.isHidden = true
            
            lblActivity.text = "error occured , try again"
            
        case .showAllPhotos:
            lblActivity.isHidden = false
            btnActivity.isHidden = false
            loadingIndicator.isHidden = true
            
            lblActivity.text = "Show all images"
            
        case .noPhotos:
            lblActivity.isHidden = false
            btnActivity.isHidden = true
            loadingIndicator.isHidden = true
            
            lblActivity.text = "Sorry no images"
        }
    }

    //MARKL - ibactions
    @IBAction func activityBtnPressed() {
        if presenter.status == .errorPhotos {
            presenter.getMoviePhotos()
        }
        else if presenter.status == .showAllPhotos {
            performSegue(withIdentifier: "ImagesListingViewController", sender: nil)
        }
    }
    
    //MARK: - navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImagesListingViewController" {
            if let vc = segue.destination as? ImagesListingViewController {
                vc.presenter = ImagesListingPresenter()
                vc.presenter.movie = presenter.movie
                vc.presenter.allPhotos = presenter.allPhotos
            }
        }
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
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == presenter.allPhotos.count - 4 {
//            self.presenter.getMoviePhotos()
//        }
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "GalleryCollectionReusableView",
                    for: indexPath) as? GalleryCollectionReusableView
                else {
                    fatalError("Invalid view type")
            }
            headerView.lblTitle.text = "Images :"
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        // Get the view for the first header
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        // Use this view to calculate the optimal size based on the collection view's width
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
            verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    
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
    
    func showActivityStatus() {
        setupActivityStatusView()
    }
    
}
