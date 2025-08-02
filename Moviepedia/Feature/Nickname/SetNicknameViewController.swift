//
//  SetNicknameViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import Toast
import UIKit

class SetNicknameViewController: UIViewController {
    
    private let setNicknameView = SetNicknameView()
    
    private var nickname = User(name: "")
        
    override func loadView() {
        view = setNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        bindAction()
    }
}

extension SetNicknameViewController: ViewControllerProtocol {
    
     func configureNavigation() {
        navigationItem.title = "닉네임 설정"
    }

    func bindAction() {
        setNicknameView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        setNicknameView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    @objc func editButtonTapped() {
        let vc = NicknameDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        vc.sendNickname = { nickname in
            self.nickname = nickname
            self.setNicknameView.nicknameTextField.text = nickname.name
        }
    }
    
    @objc func completeButtonTapped() {
        let name = setNicknameView.nicknameTextField.text!

        if name.isEmpty {
            view.makeToast("편집 버튼을 눌러 닉네임을 입력하세요.", position: .center)
        }
                
        switch nickname.isValid {
        case .success:
            NotificationCenter.default.post(name: NSNotification.Name("LoginStatusChanged"), object: nil, userInfo: ["isLoggedIn" : true])
            AppSetting.nickname = name
            AppSetting.signUpDate = Date()

        case .failure(let error):
            view.makeToast(error.localizedDescription, position: .center)
        }
    }
}
