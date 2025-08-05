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
    var navigationAction: ((Int) -> Void)?
    
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
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "원하는 검색결과를 찾지 못했습니다."
        label.textColor = .Gray2
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.isHidden = true
        
        return label
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
        addSubview(emptyLabel)
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
        
        emptyLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
            make.top.equalTo(searchBar.snp.bottom).offset(160)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationAction?(movies[indexPath.row].id)
//        let vc = MovieDetailViewController()
//        vc.id = movies[indexPath.row].id
//        
//        navigationController?.pushViewController(vc, animated: true)
    }
}
