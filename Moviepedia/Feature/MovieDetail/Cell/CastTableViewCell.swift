//
//  CastTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import UIKit

class CastTableViewCell: BaseTableViewCell {
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 26
        imageView.backgroundColor = .blue
        
        return imageView
    }()
    
    let actorNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "현빈"
        label.textColor = .W
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .bold)
        
        return label
    }()
    
    let characterNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Ahn Jung-geun"
        label.textColor = .Gray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .light)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureConstraint()
    }
    
}

extension CastTableViewCell: ViewProtocol {
    func configureSubview() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(characterNameLabel)
    }
    
    func configureConstraint() {
        profileImageView.snp.contentHuggingHorizontalPriority = 251
        characterNameLabel.snp.contentHuggingHorizontalPriority = 249
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.size.equalTo(52)
        }
        
        actorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    
        characterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(actorNameLabel.snp.trailing).offset(8)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}
