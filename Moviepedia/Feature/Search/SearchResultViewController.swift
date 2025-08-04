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
        bindAction()
    }
}

extension SearchResultViewController: ViewControllerProtocol {
    
    func configureNavigation() {
        navigationItem.title = "영화 검색"
    }
    
    func bindAction() {
        searchResultView.searchBar.delegate = self
    }
    
    func searchData(keyword: String) {
        NetworkManager.shared.request(url: MovieURL.search(keyword: keyword)) { (result: Result<Search, Error>) in
            switch result {
                
            case .success(let search):
                self.searchResultView.movies = search.results
                self.searchResultView.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchData(keyword: searchBar.text!)
    }
}
