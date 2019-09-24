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
        setupMovieDetails()
        presenter.getMoviePhotos()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            self.presenter.getMoviePhotos()
        })
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
