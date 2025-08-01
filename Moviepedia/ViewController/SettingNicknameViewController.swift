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
    }
    
    // TODO: - 닉네임 유효성에 따라 분기처리 필요
    @objc func completeButtonTapped() {
        if settingNicknameView.nicknameTextField.text!.isEmpty {
            view.makeToast("편집 버튼을 눌러 닉네임을 입력하세요.", position: .center)
        }
    }
}
