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
        label.font = .systemFont(ofSize: 19, weight: .black)
        label.textColor = .W
        
        return label
    }()
    
    lazy var editButton: UIButton = {
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
         
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    lazy var movieBoxStatusButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        
        let container = AttributeContainer([.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        config.attributedTitle = AttributedString("\(AppSetting.likeMovies.count)개의 무비박스 보관중", attributes: container)
        
        config.baseBackgroundColor = .Green2
        config.baseForegroundColor = .W
        
        button.configuration = config
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: AppNotification.likeMovieChanged.name, object: nil)
        
        return button
    }()
    
    var onEditButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubview()
        configureConstraint()
        configureStyle()
    }
}

extension ProfileView {
    
    func configureSubview() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(editButton)
        
        addSubview(stackView)
        addSubview(movieBoxStatusButton)
    }
    
    func configureConstraint() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.horizontalEdges.equalTo(safeAreaInsets).inset(12)
        }
        
        movieBoxStatusButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaInsets).inset(12)
            make.height.equalTo(36)
            make.horizontalEdges.equalTo(safeAreaInsets).inset(16)
        }
    }
    
    func configureStyle() {
        backgroundColor = .Gray3
        layer.cornerRadius = 10
    }
    
    @objc func reload() {
        print(#function)
        
        // TODO: - 구조 고쳐서 임시조치 없애기
        DispatchQueue.main.async {
            var config = self.movieBoxStatusButton.configuration
            let container = AttributeContainer([.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
            config?.attributedTitle = AttributedString("\(AppSetting.likeMovies.count)개의 무비박스 보관중", attributes: container)
            self.movieBoxStatusButton.configuration = config
        }
    }
    
    @objc func editButtonTapped() {
        print(#function)
        onEditButtonTapped?()
    }
}
