//
//  MovieDetailViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let movieDetailView = MovieDetailView()
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailViewController: ViewControllerProtocol {
    
}
