//
//  EditNicknameViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import UIKit

final class EditNicknameViewController: UIViewController {
        
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        
        textField.text = AppSetting.nickname
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

    private var nickname = User(name: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubview()
        configureConstraint()
        configureStyle()
        bindAction()
    }
}

extension EditNicknameViewController: ViewControllerProtocol {
    
    func configureSubview() {
        stackView.addArrangedSubview(nicknameTextField)
        stackView.addArrangedSubview(editButton)
        
        view.addSubview(stackView)
        view.addSubview(line)
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
    }
    
    func configureStyle() {
        view.backgroundColor = .B
        
        navigationItem.title = "닉네임 편집"
        
        let rightItem = UIBarButtonItem(title: "저장",
                                        style: .plain,
                                        target: self,
                                        action: #selector(saveButtonTapped))
        
        navigationItem.rightBarButtonItem = rightItem
        
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem = leftItem
    }
    
    func bindAction() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc private func dismissButtonTapped() {
        dismiss(animated: true)
    }

    @objc private func saveButtonTapped() {
        let newNickname = nicknameTextField.text!
        let user = User(name: newNickname)
        
        switch user.isValid {
        case .success:
            AppSetting.nickname = newNickname
        case .failure:
            break
        }
        dismiss(animated: true)
    }
    
    @objc private func editButtonTapped() {
        let vc = NicknameDetailViewController()
        vc.sendNickname = { nickname in
            self.nickname = nickname
            self.nicknameTextField.text = nickname.name
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

