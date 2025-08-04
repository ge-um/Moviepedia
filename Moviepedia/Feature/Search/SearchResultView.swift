//
//  SearchResultView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import SnapKit
import UIKit

class SearchResultView: BaseView {
    
    var movies: [SearchMovie] = []
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension SearchResultView: ViewProtocol {
    
    func configureSubview() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    func configureConstraint() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension SearchResultView: UITableViewDelegate, UITableViewDataSource {
    
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
}

