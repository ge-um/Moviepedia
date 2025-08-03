//
//  TodayMovieTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import UIKit

class TodayMovieTableViewCell: BaseTableViewCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSize(width: 240, height: 440)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    // TODO: - zz delegate 등록 여기서 해야하나
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubview()
        configureConstraint()
        configureCollectionView()
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
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
    }
}

extension TodayMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}
