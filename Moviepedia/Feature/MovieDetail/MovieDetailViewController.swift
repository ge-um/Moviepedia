//
//  MovieDetailViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let movieDetailView = MovieDetailView()
    
    let sectionTitle = ["Synopsis", "Cast"]
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureTableView()
    }
}

extension MovieDetailViewController: ViewControllerProtocol {
    
    func configureNavigation() {
        navigationItem.title = "하얼빈"
        
        // TODO: - 좋아요 데이터 userDefaults에 저장후 불러오기
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"))
    }
    
    func configureTableView() {
        movieDetailView.tableView.dataSource = self
        movieDetailView.tableView.delegate = self
        
        movieDetailView.tableView.register(SynopsisTableViewCell.self, forCellReuseIdentifier: SynopsisTableViewCell.identifier)
        movieDetailView.tableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderView.identifier)
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.identifier) as! SynopsisTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewHeaderView.identifier) as! MainTableViewHeaderView
        
        header.configureStyle(buttonTitle: "More", buttonIsHidden: false)
        header.configureWithData(sectionTitle: sectionTitle[section])
        
        return header
    }
}
