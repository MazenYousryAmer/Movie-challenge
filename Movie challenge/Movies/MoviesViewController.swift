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
    
    //MARK: - variables
    let presenter : MoviesPresenter = MoviesPresenter()
    
    //MARK: - view mthods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

