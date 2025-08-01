//
//  SettingNicknameViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import Toast
import UIKit

class SettingNicknameViewController: UIViewController {
    
    private let settingNicknameView = SettingNicknameView()
        
    override func loadView() {
        view = settingNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        bindAction()
    }
}

extension SettingNicknameViewController: ViewControllerProtocol {
     func configureNavigation() {
        navigationItem.title = "닉네임 설정"
    }

    func bindAction() {
        settingNicknameView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        settingNicknameView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    @objc func editButtonTapped() {
        let vc = DetailNicknameViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        vc.nickname = { name in
            self.settingNicknameView.nicknameTextField.text = name
        }
    }
    
    @objc func completeButtonTapped() {
        if settingNicknameView.nicknameTextField.text!.isEmpty {
            view.makeToast("편집 버튼을 눌러 닉네임을 입력하세요.", position: .center)
        }
        
        let result = validateNickname()
        
        switch result {
        case .success(_):
            navigationController?.popToRootViewController(animated: false)
        case .failure(let error):
            view.makeToast(error.localizedDescription, position: .center)
        }
    }
    
    // TODO: - 유효성 검사를 한 번만 할 순 없을까?
    func validateNickname() -> Result<Bool, ValidationError> {
        let nickname = settingNicknameView.nicknameTextField.text!
    
        if !nickname.isValidLength {
            return .failure(.invalidLength)
        } else if nickname.hasSpecialCharacter {
            return .failure(.containsSpecialCharacter)
        } else if nickname.hasNumber {
            return .failure(.containsNumber)
        }
        
        return .success(true)
    }
}
