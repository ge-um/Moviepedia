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
    
    var movies: [SearchMovie] = []
    
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
        searchResultView.tableView.delegate = self
        searchResultView.tableView.dataSource = self
    }
    
    func searchData(keyword: String) {
        NetworkManager.shared.request(url: MovieURL.search(keyword: keyword)) { (result: Result<SearchMovieResponse, Error>) in
            switch result {
                
            case .success(let search):
                self.movies = search.results
                self.reloadView()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func reloadView() {
        if movies.isEmpty {
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

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier) as! SearchResultTableViewCell
        
        cell.configureData(movie: movies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // TODO: - 눌렀을 때 하트 동작하지 않음. 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        let vc = MovieDetailViewController()
        vc.searchMovie = movie
        vc.id = movie.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
