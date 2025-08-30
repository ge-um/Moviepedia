//
//  RecentSearchTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import SnapKit
import UIKit

class RecentSearchTableViewCell: BaseTableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = .init(top: 12, left: 0, bottom: 12, right: 0)
        layout.itemSize = .init(width: 80, height: 28)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: KeywordCollectionViewCell.identifier)
        
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어 내역이 없습니다."
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .Gray2
        label.isHidden = true
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubview()
        configureConstraint()
        bindAction()
    }
    
    func bindAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(renewKeyword), name: AppNotification.keywordSearched.name, object: nil)
    }
    
    @objc func renewKeyword() {
        collectionView.reloadData()
    }
}

extension RecentSearchTableViewCell {
    
    func configureSubview() {
        contentView.addSubview(collectionView)
        contentView.addSubview(label)
    }
    
    func configureConstraint() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension RecentSearchTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppSetting.keyword.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.identifier, for: indexPath) as! KeywordCollectionViewCell
        
        cell.configureData(text: AppSetting.keyword[indexPath.row] as! String)
        
        cell.deleteAction = {
            AppSetting.keyword.remove(at: indexPath.row)
        }
        
        return cell
    }
}
