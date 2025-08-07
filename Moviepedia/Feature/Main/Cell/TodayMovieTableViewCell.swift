//
//  TodayMovieTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import UIKit

class TodayMovieTableViewCell: BaseTableViewCell {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSize(width: 240, height: 440)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    var trendingMovies: [TrendingMovie] = []
    var didSelectMovie: ((TrendingMovie) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubview()
        configureConstraint()
        configureData()
        
        collectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TodayMovieTableViewCell: ViewProtocol {
    
    func configureSubview() {
        contentView.addSubview(collectionView)
    }
    
    func configureConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(420)
        }
    }
    
    func configureData() {
        NetworkManager.shared.request(url: MovieURL.trending) { (result: Result<TrendingMovieResponse, Error>) in
            
            switch result {
            case .success(let trendingMovieResponse):
                
                self.trendingMovies = trendingMovieResponse.results
                self.collectionView.reloadData()

            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension TodayMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(trendingMovies.count, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.identifier, for: indexPath) as! TodayMovieCollectionViewCell
        
        let movie = trendingMovies[indexPath.item]
        
        cell.id = movie.id
        cell.configureWithData(movie: movie)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = trendingMovies[indexPath.row]

        didSelectMovie?(movie)
    }
}
