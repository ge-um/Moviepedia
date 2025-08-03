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
        bindAction()
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
        mainView.tableView.register(TodayMovieTableViewCell.self, forCellReuseIdentifier: TodayMovieTableViewCell.identifier)

        mainView.tableView.isScrollEnabled = false
    }
    
    // TODO: - 똑같은 함수를 똑같이 다른 뷰컨에 정의하는게 맞나?
    func bindAction() {
        mainView.profileView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeNickname), name: NSNotification.Name("nicknameChanged"), object: nil)
    }
    
    @objc func editButtonTapped() {
        print(#function)
        let modal = UINavigationController(rootViewController: EditNicknameViewController())
        modal.modalPresentationStyle = .pageSheet
        modal.sheetPresentationController?.prefersGrabberVisible = true
        present(modal, animated: true)
    }
    
    @objc func changeNickname(notification: NSNotification) {
        if let nickname = notification.userInfo?["nickname"] as? String {
            mainView.profileView.nameLabel.text = nickname
        }
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
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier) as! RecentSearchTableViewCell
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayMovieTableViewCell.identifier) as! TodayMovieTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewHeaderFooterView.identifier) as! MainTableViewHeaderFooterView
        
        header.title.text = sectionTitle[section]
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 44 : 480
    }
}
