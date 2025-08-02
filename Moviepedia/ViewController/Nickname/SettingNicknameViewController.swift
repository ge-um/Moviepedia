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
    
    private var nickname = Nickname(name: "")
        
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
        
        vc.sendNickname = { nickname in
            self.nickname = nickname
            self.settingNicknameView.nicknameTextField.text = nickname.name
        }
    }
    
    @objc func completeButtonTapped() {
        let name = settingNicknameView.nicknameTextField.text!

        if name.isEmpty {
            view.makeToast("편집 버튼을 눌러 닉네임을 입력하세요.", position: .center)
        }
                
        switch nickname.isValid {
        case .success:
            NotificationCenter.default.post(name: NSNotification.Name("LoginStatusChanged"), object: nil, userInfo: ["isLoggedIn" : true])

        case .failure(let error):
            view.makeToast(error.localizedDescription, position: .center)
        }
    }
}
