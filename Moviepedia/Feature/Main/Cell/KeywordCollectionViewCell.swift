//
//  KeywordCollectionViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/5/25.
//

import SnapKit
import UIKit

class KeywordCollectionViewCell: BaseCollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        
        label.text = "스파이더"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .B
        label.layer.cornerRadius = 10
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .B
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let containerView: UIView = {
       let view = UIView()

        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
    
    func configureData(text: String) {
        label.text = text
    }
}

extension KeywordCollectionViewCell: ViewProtocol {
    
    func configureSubview() {
        
        containerView.addSubview(label)
        containerView.addSubview(imageView)
        
        contentView.addSubview(containerView)
    }
    
    func configureConstraint() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).offset(8)
            make.size.equalTo(10)
        }
        
        containerView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}
