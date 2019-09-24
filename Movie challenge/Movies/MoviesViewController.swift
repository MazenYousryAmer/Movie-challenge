//
//  ViewController.swift
//  Movie challenge
//
//  Created by Mazen on 9/20/19.
//  Copyright © 2019 Mazen. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    //MARK: - iboutlets
    @IBOutlet var tableMovies : UITableView!
    @IBOutlet var searchBarMovie : UISearchBar!
    
    //MARK: - variables
    let presenter : MoviesPresenter = MoviesPresenter()
    
    //MARK: - view mthods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
        self.navigationItem.title = "MOVIES"
    }
    
    //MARK: - setup
    func setup() {
        setupPresenter()
        setupModel()
        setupTableHeight()
    }
    
    func setupPresenter() {
        presenter.moviesDelegate = self
    }
    
    func setupModel() {
        presenter.getAllMovies()
    }
    
    func setupTableHeight() {
        // table configuration
        tableMovies.estimatedRowHeight = 50.0
        tableMovies.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: - navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController" {
            if let vc = segue.destination as? DetailsViewController {
                vc.presenter = DetailsPresenter()
                vc.presenter.movie = sender as? Movie                
            }
        }
    }
}

extension MoviesViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.filteredMovies.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filteredMovies[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        if let moviesOfTheYear = presenter.filteredMovies[indexPath.section] as? [Movie] {
            if let movie = moviesOfTheYear[indexPath.row] as? Movie {
                cell.lblMovieTitle.text = movie.title
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let moviesOfTheYear = presenter.filteredMovies[section] as? [Movie] {
            if let movie = moviesOfTheYear[0] as? Movie {
                return String(movie.year)
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let moviesOfTheYear = presenter.filteredMovies[indexPath.section] as? [Movie] {
            if let movie = moviesOfTheYear[indexPath.row] as? Movie {
                // push segue
                self.performSegue(withIdentifier: "DetailsViewController", sender: movie)
            }
        }
    }
}

extension MoviesViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.cancelSearchHandler()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("here")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespaces) == "" {
            presenter.cancelSearchHandler()
        }
        else {
            if searchBar.selectedScopeButtonIndex == 0 {
                presenter.titleSearchHandler(searchText)
            }
            else {
                presenter.castSearchHandler(searchText)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
    }
}

extension MoviesViewController : MoviesProtocol {
    func reloadMovies() {
        tableMovies.reloadData()
    }
    
    
}
