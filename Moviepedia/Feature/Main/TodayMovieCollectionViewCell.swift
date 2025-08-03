//
//  TodayMovieCollectionViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import SnapKit
import UIKit

class TodayMovieCollectionViewCell: BaseCollectionViewCell {
    
    let movieImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
        
    }()
    
    //TODO: - color white -> W로 바꾸기
    let movieTitle: UILabel = {
        let label  = UILabel()
        
        label.text = "티키키"
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .W
        
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        
        button.configuration = config
        
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    let movieDescription: UILabel = {
        let label = UILabel()
        
        label.text = "으아아진짜긴영화제목으아아진짜긴영화제목으아아진짜긴영화제목으아아진짜긴영화제목으아아진짜긴영화제목으아아진짜긴영화제목으아아진짜긴영화제목아니설명이구나아니설명이구나아니설명이구나아니설명이구나아니설명이구나"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .W
        label.numberOfLines = 3
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubview()
        configureConstraint()
    }
}

extension TodayMovieCollectionViewCell: ViewProtocol {
    // TODO: - 왜 contentView에 넣더라?
    func configureSubview() {
        contentView.addSubview(movieImageView)
        
        stackView.addArrangedSubview(movieTitle)
        stackView.addArrangedSubview(likeButton)
        
        contentView.addSubview(stackView)
        contentView.addSubview(movieDescription)
    }
    
    func configureConstraint() {
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.height.equalTo(340)
            make.horizontalEdges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        movieDescription.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
