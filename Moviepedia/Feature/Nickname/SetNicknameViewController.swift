//
//  SetNicknameViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import Toast
import UIKit

class SetNicknameViewController: UIViewController {
        
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .W
        textField.font = .systemFont(ofSize: 13)
        textField.isEnabled = false
        
        return textField
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 20, bottom: 8, trailing: 20)
        let container = AttributeContainer([.font: UIFont.systemFont(ofSize: 14, weight: .bold), .foregroundColor: UIColor.W])
        
        config.attributedTitle = AttributedString("편집", attributes: container)
        
        config.cornerStyle = .capsule
        config.background.strokeColor = .W
        config.background.strokeWidth = 1
        
        button.configuration = config
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        
        return stackView
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .W
        
        return view
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.bordered(title: "완료")

        return button
    }()

    private var nickname = User(name: "")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureConstraint()
        configureNavigation()
        bindAction()
    }
}

extension SetNicknameViewController: ViewControllerProtocol {
    
    func configureSubview() {
        stackView.addArrangedSubview(nicknameTextField)
        stackView.addArrangedSubview(editButton)
        
        view.addSubview(stackView)
        view.addSubview(line)
        view.addSubview(completeButton)
    }
    
    func configureConstraint() {
        nicknameTextField.snp.contentHuggingHorizontalPriority = 249
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.leading.equalTo(stackView)
            make.trailing.equalTo(stackView).inset(42)
            make.height.equalTo(1)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
    }
    
     func configureNavigation() {
        navigationItem.title = "닉네임 설정"
    }

    func bindAction() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func editButtonTapped() {
        let vc = NicknameDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        vc.sendNickname = { nickname in
            self.nickname = nickname
            self.nicknameTextField.text = nickname.name
        }
    }
    
    @objc func completeButtonTapped() {
        let name = nicknameTextField.text!

        if name.isEmpty {
            view.makeToast("편집 버튼을 눌러 닉네임을 입력하세요.", position: .center)
        }
                
        switch nickname.isValid {
        case .success:
            AppSetting.nickname = name
            AppSetting.signUpDate = Date()
            
            NotificationCenter.default.post(name: NSNotification.Name("LoginStatusChanged"), object: nil, userInfo: ["isLoggedIn" : true])

        case .failure(let error):
            view.makeToast(error.localizedDescription, position: .center)
        }
    }
}
