//
//  OnboardingViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
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
        button.configuration = UIButton.Configuration.bordered(title: "시작하기")
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureConstraint()
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
}

extension OnboardingViewController {
    
    func configureSubview() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(startButton)
    }
    
    func configureConstraint() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(228)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(96)
            make.centerX.equalTo(view.safeAreaLayoutGuide)

        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(200)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(44)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
    }
    
    func bindAction() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        let vc = NicknameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
