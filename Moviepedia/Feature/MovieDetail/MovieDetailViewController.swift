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
    var movie: Movie?
    var cast: [Cast]?
    
    lazy var isLiked = AppSetting.likeMovies.contains(movie?.id ?? -1)
    var reloadAction: (() -> Void)?
    
    lazy var likeButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        config.baseBackgroundColor = .clear
        
        button.configuration = config
        
        button.configurationUpdateHandler = {
            button in
            var config = button.configuration
            
            config?.image = button.isSelected ?
            UIImage(systemName: "heart.fill") :
            UIImage(systemName: "heart")
            
            button.configuration = config
        }
        
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return button
    }()
        
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureTableView()
        configureData()
    }
}

extension MovieDetailViewController: ViewControllerProtocol {
    
    func configureNavigation() {
        navigationItem.title = movie?.title
        
        let heartImage = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        let rightButton = UIBarButtonItem(
            image: heartImage,
            style: .plain,
            target: self,
            action: #selector(likeButtonTapped)
        )
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func configureTableView() {
        movieDetailView.tableView.dataSource = self
        movieDetailView.tableView.delegate = self
        
        movieDetailView.tableView.register(SynopsisTableViewCell.self, forCellReuseIdentifier: SynopsisTableViewCell.identifier)
        movieDetailView.tableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderView.identifier)
        
        movieDetailView.tableView.register(BackdropHeaderView.self, forHeaderFooterViewReuseIdentifier:  BackdropHeaderView.identifier)
    }
    
    func configureData() {
        NetworkManager.shared.request(url: MovieURL.credit(id: movie!.id)) { (result: Result<Credit, Error>) in
            switch result {
            case .success(let credit):
                self.cast = credit.cast
                self.movieDetailView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc func likeButtonTapped() {
        isLiked.toggle()
        
        let newImage = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        navigationItem.rightBarButtonItem?.image = newImage
        
        guard let id = movie?.id else { return }
        
        if isLiked {
            if !AppSetting.likeMovies.contains(id) {
                AppSetting.likeMovies.append(id)
            }
        } else {
            AppSetting.likeMovies.removeAll { $0 == id }
        }
        
        reloadAction?()
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = cast?.count else { return 1 }
        return section == 0 ? 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.identifier) as! SynopsisTableViewCell
            
            cell.label.text = movie?.overview

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as! CastTableViewCell
            
            guard let cast = cast?[indexPath.row] else { return UITableViewCell() }
            
            cell.configureData(cast: cast)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.section == 0 ? UITableView.automaticDimension : 68
    }
    
    // TODO: - Header 재활용 방법 생각해보기.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BackdropHeaderView.identifier) as! BackdropHeaderView
            
            header.configureStyle(buttonTitle: "More", buttonIsHidden: false)
            header.configureWithData(sectionTitle: sectionTitle[section])
            
            // TODO: - 강제 언래핑 제거하기
            NetworkManager.shared.request(url: MovieURL.backdrop(id: movie!.id)) { (result: Result<MovieImage, Error>) in
                                
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
