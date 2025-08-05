//
//  SearchResultViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import UIKit

// TODO: 검색 버그 있음.
class SearchResultViewController: UIViewController {
    
    let searchResultView = SearchResultView()
    
    override func loadView() {
        let newView = searchResultView
        newView.navigationAction = { id in
            let vc = MovieDetailViewController()
            vc.id = id
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
                self.reloadView()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func reloadView() {
        if searchResultView.movies.isEmpty {
            searchResultView.emptyLabel.isHidden = false
        } else {
            searchResultView.emptyLabel.isHidden = true
            searchResultView.tableView.reloadData()
        }
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let keyword = searchBar.text!
        
        AppSetting.keyword.append(keyword)
        searchData(keyword: keyword)
    }
}
