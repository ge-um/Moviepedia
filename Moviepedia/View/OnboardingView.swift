//
//  OnboardingView.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

final class OnboardingView: BaseView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")
        imageView.contentMode = .top
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Onboarding"
        label.font = .init(name: "HelveticaNeue-BoldItalic", size: 36)
        label.textColor = .W
        
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "당신만의 영화 세상, Moviepedia를 시작해보세요."
        label.textColor = .W
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        
        return stackView
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
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(nameLabel)
        
        addSubview(stackView)
        addSubview(startButton)
    }
    
    func configureConstraint() {
        imageView.snp.contentHuggingVerticalPriority = 249
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(172)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(88)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
    }
}
