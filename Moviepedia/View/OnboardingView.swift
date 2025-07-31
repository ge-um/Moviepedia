//
//  OnboardingView.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

final class OnboardingView: BaseView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")
        imageView.contentMode = .top
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Onboarding"
        label.font = .init(name: "HelveticaNeue-BoldItalic", size: 36)
        label.textColor = .W
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "당신만의 영화 세상, Moviepedia를 시작해보세요."
        label.textColor = .W
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()

    let startButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        let container = AttributeContainer([.font: UIFont.systemFont(ofSize: 15, weight: .bold)])
        
        config.attributedTitle = AttributedString("시작하기", attributes: container)
        config.cornerStyle = .capsule
        config.background.strokeColor = .Green
        config.background.strokeWidth = 1
        
        button.configuration = config
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension OnboardingView: ViewProtocol {
    
    func configureSubview() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(startButton)
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
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(44)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
    }
}
