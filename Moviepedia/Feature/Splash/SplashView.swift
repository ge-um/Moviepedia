//
//  SplashView.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import SnapKit
import UIKit

final class SplashView: BaseView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")
        imageView.contentMode = .top
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Moviepedia"
        label.font = .init(name: "HelveticaNeue-BoldItalic", size: 36)
        label.textColor = .W
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "금가경"
        label.textColor = .W
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension SplashView {
    
    func configureSubview() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(nameLabel)
    }
    
    func configureConstraint() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(228)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(96)
            make.centerX.equalTo(safeAreaLayoutGuide)

        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(200)
        }
    }
}
