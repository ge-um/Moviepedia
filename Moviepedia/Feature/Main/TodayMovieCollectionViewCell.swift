//
//  TodayMovieCollectionViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import SnapKit
import UIKit
import Kingfisher

class TodayMovieCollectionViewCell: BaseCollectionViewCell {
    
    let moviePosterView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    //TODO: - color white -> W로 바꾸기
    let movieTitle: UILabel = {
        let label  = UILabel()
        
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
    
    // TODO: - 타이틀이 너무 길 때 좋아요 버튼이 레이아웃에서 없어지는 문제 해결하기
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    // TODO: - Overview가 nil일때 텍스트 안 내려오게 하기
    let movieOverview: UILabel = {
        let label = UILabel()
        
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
        contentView.addSubview(moviePosterView)
        
        stackView.addArrangedSubview(movieTitle)
        stackView.addArrangedSubview(likeButton)
        
        contentView.addSubview(stackView)
        contentView.addSubview(movieOverview)
    }
    
    func configureConstraint() {
        moviePosterView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.height.equalTo(340)
            make.horizontalEdges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(moviePosterView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        movieOverview.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureWithData(movie: Movie) {
        if let url = URL(string: MovieURL.image + movie.poster_path) {
            moviePosterView.kf.setImage(with: url,
                                        options:
                                            [.processor(DownsamplingImageProcessor(size: moviePosterView.bounds.size)),
                                             .scaleFactor(UIScreen.main.scale),
                                             .cacheOriginalImage,
                                             .memoryCacheExpiration(.days(1))
                                            ])
        }
        movieTitle.text = movie.title
        movieOverview.text = movie.overview
    }
}
