//
//  SearchResultTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import SnapKit
import Kingfisher
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

        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .W
        
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 13, weight: .light)
        
        label.textColor = .W
        
        return label
    }()
    
    let genreStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        return stackView
    }()
    
    let genreLabel1: UILabel = {
        let label = UILabel()
        
        label.textColor = .W
        label.font = .systemFont(ofSize: 13)
        label.backgroundColor = .Gray2
        
        return label
    }()
    
    let genreLabel2: UILabel = {
        let label = UILabel()
        
        label.textColor = .W
        label.backgroundColor = .Gray2
        label.font = .systemFont(ofSize: 13)
        
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
        
        genreStackView.addArrangedSubview(genreLabel1)
        genreStackView.addArrangedSubview(genreLabel2)

        addSubview(genreStackView)
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
        
        genreStackView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.bottom.equalTo(posterImageView.snp.bottom)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(genreStackView.snp.trailing).offset(12)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(posterImageView.snp.bottom)
        }
    }
    
    func configureData(movie: SearchMovie) {
        
        guard let path = movie.poster_path else { return }
        let url = URL(string: MovieURL.image + path)
        
        posterImageView.kf.setImage(with: url, options:
                                        [.processor(DownsamplingImageProcessor(size: posterImageView.bounds.size)),
                                         .scaleFactor(UIScreen.main.scale),
                                         .cacheOriginalImage,
                                         .memoryCacheExpiration(.days(1))
                                        ])
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        
        
        let genre = movie.genre_ids
        
        if !genre.isEmpty {
            if genre.count == 1 {
                genreLabel1.text = Genre(rawValue: genre[0])!.name
                return
            }
            
            if genre.count >= 2 {
                genreLabel2.text = Genre(rawValue: genre[1])!.name
            }
        }

        likeButton.isSelected = AppSetting.likeMovies.contains(movie.id)
    }
}
