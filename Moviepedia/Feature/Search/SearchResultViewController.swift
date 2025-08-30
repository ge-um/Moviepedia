//
//  SearchResultViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import UIKit

// TODO: 검색 버그 있음.
class SearchResultViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .black
        searchBar.placeholder = "영화를 검색해보세요."
        
        searchBar.becomeFirstResponder()
                
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        
        return tableView
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "원하는 검색결과를 찾지 못했습니다."
        label.textColor = .Gray2
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    var movies: [SearchMovie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .B
        
        configureSubview()
        configureConstraint()
        configureNavigation()
        bindAction()
    }
}

extension SearchResultViewController {
    
    func configureNavigation() {
        navigationItem.title = "영화 검색"
    }
    
    func bindAction() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
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
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
            tableView.reloadData()
        }
    }
    
    func configureSubview() {
        view.addSubview(searchBar)
        view.addSubview(emptyLabel)
        view.addSubview(tableView)
    }
    
    func configureConstraint() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.top.equalTo(searchBar.snp.bottom).offset(160)
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
