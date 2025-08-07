//
//  MainViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

class MainViewController: UIViewController {
        
    lazy var profileView: ProfileView = {
        let view = ProfileView()
        
        view.onEditButtonTapped = {
            print(#function)
            let modal = UINavigationController(rootViewController: EditNicknameViewController())
            modal.modalPresentationStyle = .pageSheet
            modal.sheetPresentationController?.prefersGrabberVisible = true
            self.present(modal, animated: true)
        }
        
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    let sectionTitle = ["최근검색어", "오늘의 영화"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .B
        
        configureSubview()
        configureConstraint()
        configureNavigation()
        configureTableView()
        bindAction()
    }
}

extension MainViewController: ViewControllerProtocol {
    
    func configureSubview() {
        view.addSubview(profileView)
        view.addSubview(tableView)
    }
    
    func configureConstraint() {
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(96)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.sectionHeaderTopPadding = 0
    }
    
    func configureNavigation() {
        navigationItem.title = "Moviepedia"
        
        let rightButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "magnifyingglass"), target: self, action: #selector(searchButtonTapped))
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        tableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderView.identifier)
        tableView.register(TodayMovieTableViewCell.self, forCellReuseIdentifier: TodayMovieTableViewCell.identifier)

        tableView.isScrollEnabled = false
    }
    
    // TODO: - 똑같은 함수를 똑같이 다른 뷰컨에 정의하는게 맞나?
    func bindAction() {
//        profileView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeNickname), name: AppNotification.nicknameChanged.name, object: nil)
    }

//    @objc func editButtonTapped() {
//        print(#function)
//        let modal = UINavigationController(rootViewController: EditNicknameViewController())
//        modal.modalPresentationStyle = .pageSheet
//        modal.sheetPresentationController?.prefersGrabberVisible = true
//        present(modal, animated: true)
//    }
    
    @objc func changeNickname(notification: NSNotification) {
        if let nickname = notification.userInfo?["nickname"] as? String {
            profileView.nameLabel.text = nickname
        }
    }
    
    @objc func searchButtonTapped() {
        let vc = SearchResultViewController()
        navigationController?.pushViewController(vc, animated: true)
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
            
            cell.didSelectMovie = { movie in
                let vc = MovieDetailViewController()
                
                vc.id = movie.id
                vc.trendingMovie = movie
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewHeaderView.identifier) as! MainTableViewHeaderView
        
        header.title.text = sectionTitle[section]
        
        if section == 0 {
            header.configureStyle(buttonTitle: "전체 삭제", buttonIsHidden: false)
        }

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 44 : 480
    }
}
