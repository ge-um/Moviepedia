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
    
    var id: Int?
    
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
        
        movieDetailView.tableView.register(BackdropHeaderView.self, forHeaderFooterViewReuseIdentifier:  BackdropHeaderView.identifier)
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
    
    // TODO: - Header 재활용 방법 생각해보기.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BackdropHeaderView.identifier) as! BackdropHeaderView
            
            header.configureStyle(buttonTitle: "More", buttonIsHidden: false)
            header.configureWithData(sectionTitle: sectionTitle[section])
            
            NetworkManager.shared.request(url: MovieURL.backdrop(id: id!)) { (result: Result<MovieImage, Error>) in
                                
                switch result {
                    
                case .success(let response):
                    header.images = response.backdrops
                    header.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
                        
            return header
            
        } else {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewHeaderView.identifier) as! MainTableViewHeaderView
            
            header.configureStyle(buttonTitle: "More", buttonIsHidden: true)
            header.configureWithData(sectionTitle: sectionTitle[section])
            
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : UITableView.automaticDimension
    }
}

