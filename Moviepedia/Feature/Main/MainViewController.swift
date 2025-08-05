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
    var trendingMovies: [Movie] = []
    
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
        
        let rightButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "magnifyingglass"), target: self, action: #selector(searchButtonTapped))
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func configureTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        mainView.tableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderView.identifier)
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
            
            cell.collectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            
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

// TODO: - 이게맞나.ㅎ 분리 어떻게 안될까
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    // TODO: cell에서 업데이트 안하도록 분리
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.identifier, for: indexPath) as! TodayMovieCollectionViewCell
                
        NetworkManager.shared.request(url: MovieURL.trending) { (result: Result<TrendingMovie, Error>) in
            
            switch result {
            case .success(let todayMovie):
                
                self.trendingMovies = todayMovie.results
                
                let movie = todayMovie.results[indexPath.row]
                
                cell.id = movie.id

                cell.configureWithData(movie: movie)
                
                self.mainView.tableView.reloadData()

            case .failure(let error):
                print(error)
                break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = trendingMovies[indexPath.row]
        
        let vc = MovieDetailViewController()
        vc.title = movie.title
        vc.id = movie.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
