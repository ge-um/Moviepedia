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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubview()
        configureConstraint()
        
        NotificationCenter.default.addObserver(self, selector: #selector(likeButtonTapped), name: NSNotification.Name("LikeMovieChanged"), object: nil)
    }
    
    @objc func likeButtonTapped() {
        collectionView.reloadData()
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
}
