//
//  MainViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    let sectionTitle = ["최근검색어", "오늘의 영화"]
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
    }
}

extension MainViewController: ViewControllerProtocol {
    
    func configureNavigation() {
        navigationItem.title = "Moviepedia"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"))
    }
    
    func configureTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        mainView.tableView.register(MainTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderFooterView.identifier)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier) as? RecentSearchTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewHeaderFooterView.identifier) as! MainTableViewHeaderFooterView
        
        header.title.text = sectionTitle[section]
        
        return header
    }
}
