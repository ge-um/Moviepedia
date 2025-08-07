//
//  NicknameDetailViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

import UIKit

// TODO: - 클로저 구문 없애기
final class NicknameDetailViewController: UIViewController {
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .W
        textField.font = .systemFont(ofSize: 13)
        
        return textField
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .W
        
        return view
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .Green
        
        return label
    }()
    
    var sendNickname: ((User) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubview()
        configureConstraint()
        configureNavigation()
        bindAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let nickname = User(name: nicknameTextField.text!)
        sendNickname?(nickname)
    }
}

extension NicknameDetailViewController: ViewControllerProtocol {
    
    func configureSubview() {
        view.addSubview(nicknameTextField)
        view.addSubview(line)
        view.addSubview(errorLabel)
    }
    
    func configureConstraint() {
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.horizontalEdges.equalTo(nicknameTextField)
            make.height.equalTo(1)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(nicknameTextField).inset(8)
        }
    }
    
    func configureNavigation() {
        if let _ = navigationController?.viewControllers.first as? EditNicknameViewController {
            navigationItem.title = "닉네임 편집"
        } else {
            navigationItem.title = "닉네임 설정"
        }
    }
    
    func bindAction() {
        nicknameTextField.becomeFirstResponder()
        
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingDidChange), for: .editingChanged)
    }
    
    // TODO: - 에러는 묶었는데 성공은 묶을 수 없을까?
    @objc func nicknameTextFieldEditingDidChange() {
        let name = nicknameTextField.text!
        guard !name.isEmpty else {
            errorLabel.text = ""
            return
        }
        
        let nickname = User(name: name)
        let message: String
        
        switch nickname.isValid {
        case .success:
            message = "사용할 수 있는 닉네임이에요."
        case .failure(let error):
            message = error.localizedDescription
        }
        
        errorLabel.text = message
    }
}
