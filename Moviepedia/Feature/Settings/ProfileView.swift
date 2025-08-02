//
//  ProfileView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

class ProfileView: BaseView {
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = AppSetting.nickname
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .W
        
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        let date = formatter.string(from: AppSetting.signUpDate) + " 가입"
        
        let container = AttributeContainer([.font: UIFont.systemFont(ofSize: 14)])
        config.attributedTitle = AttributedString(date, attributes: container)
        
        config.image = UIImage(systemName: "chevron.right")
        config.imagePlacement = .trailing
        config.imagePadding = 8
        config.baseForegroundColor = .Gray2
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button.configuration = config
        
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    let movieBoxStatusButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        
        let container = AttributeContainer([.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        config.attributedTitle = AttributedString("0개의 무비박스 보관중", attributes: container)
        
        config.baseBackgroundColor = .Green2
        config.baseForegroundColor = .W
        
        button.configuration = config
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubview()
        configureConstraint()
        configureStyle()
    }
}

extension ProfileView: ViewProtocol {
    func configureSubview() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(editButton)
        
        addSubview(stackView)
        addSubview(movieBoxStatusButton)
    }
    
    func configureConstraint() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.horizontalEdges.equalTo(safeAreaInsets).inset(16)
        }
        
        movieBoxStatusButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaInsets).inset(16)
            make.height.equalTo(36)
            make.horizontalEdges.equalTo(safeAreaInsets).inset(16)
        }
    }
    
    func configureStyle() {
        backgroundColor = .Gray3
        layer.cornerRadius = 10
    }
}
