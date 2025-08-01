//
//  DetailNicknameViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

import UIKit

// TODO: - 닉네임 작성되었다면 기존 닉네임 보여주기 분기처리하기
class DetailNicknameViewController: UIViewController {
    
    private let detailNicknameView = DetailNicknameView()
    
    var nickname: ((String) -> Void)?
        
    override func loadView() {
        view = detailNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        bindAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        nickname?(detailNicknameView.nicknameTextField.text!)
    }
}

extension DetailNicknameViewController: ViewControllerProtocol {
    
    func configureNavigation() {
        navigationItem.title = "닉네임 설정"
    }
    
    func bindAction() {
        detailNicknameView.nicknameTextField.becomeFirstResponder()
        
        detailNicknameView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingDidChange), for: .editingChanged)
    }
    
    // TODO: - 에러는 묶었는데 성공은 묶을 수 없을까?
    @objc func nicknameTextFieldEditingDidChange() {
        guard !detailNicknameView.nicknameTextField.text!.isEmpty else {
            detailNicknameView.errorLabel.text = ""
            return
        }
        
        let result = validateNickname()
        let message: String
        
        switch result {
        case .success(_):
            message = "사용할 수 있는 닉네임이에요."
        case .failure(let error):
            message = error.localizedDescription
        }
        
        detailNicknameView.errorLabel.text = message
    }
    
    // TODO: - 유효성 검사 방식 더 고민해보기
    // TODO: - viewController에 닉네임 검사 로직이 있는게 맞는가?
    func validateNickname() -> Result<Bool, ValidationError> {
        let nickname = detailNicknameView.nicknameTextField.text!
    
        if nickname.isValidLength {
            return .failure(.invalidLength)
        } else if nickname.hasSpecialCharacter {
            return .failure(.containsSpecialCharacter)
        } else if nickname.hasNumber {
            return .failure(.containsNumber)
        }
        
        return .success(true)
    }
}
