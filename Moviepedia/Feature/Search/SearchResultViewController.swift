//
//  SearchResultViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    let searchResultView = SearchResultView()
    
    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
    }
}

extension SearchResultViewController: ViewControllerProtocol {
    func configureNavigation() {
        navigationItem.title = "영화 검색"
    }
}
