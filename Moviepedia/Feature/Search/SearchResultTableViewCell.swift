//
//  SearchResultTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import SnapKit
import UIKit

class SearchResultTableViewCell: BaseTableViewCell {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .systemPink
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "정말정ㅁ라긴제목정말정ㅁ라긴제목정말정ㅁ라긴제목정말정ㅁ라긴제목정말정ㅁ라긴제목정말정ㅁ라긴제목정말정ㅁ라긴제목"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .W
        
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 13, weight: .light)
        
        label.text = "12341234"
        label.textColor = .W
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        
        label.text = "꺆꺄꺄꺆ㄲ"
        label.textColor = .Gray2
        
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        config.baseBackgroundColor = .clear
        config.contentInsets = .zero
        
        button.configuration = config
        
        button.configurationUpdateHandler = {
            button in
            var config = button.configuration
            
            config?.image = button.isSelected ?
            UIImage(systemName: "heart.fill") :
            UIImage(systemName: "heart")
            
            button.configuration = config
        }
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureConstraint()
    }
}

extension SearchResultTableViewCell: ViewProtocol {
    
    func configureSubview() {
        addSubview(posterImageView)
        addSubview(likeButton)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(genreLabel)
    }
    
    func configureConstraint() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(12)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(12)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(12)
            make.top.equalTo(posterImageView.snp.top)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.bottom.equalTo(posterImageView.snp.bottom)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(genreLabel.snp.trailing).offset(12)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(posterImageView.snp.bottom)
        }
    }
}
