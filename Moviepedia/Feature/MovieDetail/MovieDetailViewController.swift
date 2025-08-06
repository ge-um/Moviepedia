//
//  MovieDetailViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var id: Int?

    let sectionTitle = ["Synopsis", "Cast"]
    
    var trendingMovie: TrendingMovie?
    var searchMovie: SearchMovie?
    var cast: [Cast]?
    
    lazy var isLiked = AppSetting.likeMovies.contains(id!)
    
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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        
        tableView.register(SynopsisTableViewCell.self, forCellReuseIdentifier: SynopsisTableViewCell.identifier)
        
        tableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderView.identifier)
        
        tableView.register(BackdropHeaderView.self, forHeaderFooterViewReuseIdentifier:  BackdropHeaderView.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .B
        
        configureSubview()
        configureConstraint()
        configureNavigation()
        configureTableView()
        configureData()
    }
}

extension MovieDetailViewController: ViewControllerProtocol {
    
    func configureSubview() {
        view.addSubview(tableView)
    }
    
    func configureConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNavigation() {
        navigationItem.title = title
        
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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configureData() {
        NetworkManager.shared.request(url: MovieURL.credit(id: id!)) { (result: Result<CreditResponse, Error>) in
            switch result {
            case .success(let credit):
                self.cast = credit.cast
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc func likeButtonTapped() {
        isLiked.toggle()
        
        let newImage = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        navigationItem.rightBarButtonItem?.image = newImage
        
        guard let id = id else { return }
        
        if isLiked {
            if !AppSetting.likeMovies.contains(id) {
                AppSetting.likeMovies.append(id)
            }
        } else {
            AppSetting.likeMovies.removeAll { $0 == id }
        }
    }
    
    @objc func moreButtonTapped(sender: UIButton) {
        print(#function)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as? SynopsisTableViewCell
        
        sender.isSelected.toggle()
        cell?.label.numberOfLines = sender.isSelected ? 0 : 3
        tableView.reloadData()
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
            
            if let overview = trendingMovie?.overview {
                cell.label.text = overview
            } else if let overview = searchMovie?.overview {
                cell.label.text = overview
            }
            
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
            header.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            
            if let movie = searchMovie {
                header.dateLabel.text = movie.release_date
                header.rateLabel.text = "\(movie.vote_average)"
                header.genreLabel.text = movie.genre_ids.prefix(2).map { Genre(rawValue: $0)!.name }.joined(separator: ", ")
            } else if let movie = trendingMovie {
                header.dateLabel.text = movie.release_date
                header.rateLabel.text = "\(movie.vote_average)"
                header.genreLabel.text = movie.genre_ids.prefix(2).map { Genre(rawValue: $0)!.name }.joined(separator: ", ")
            }

            
            // TODO: - 강제 언래핑 제거하기
            NetworkManager.shared.request(url: MovieURL.backdrop(id: id!)) { (result: Result<BackdropResponse, Error>) in
                                
                switch result {
                    
                case .success(let response):
                    header.images = response.backdrops.prefix(5).map { $0 }
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
