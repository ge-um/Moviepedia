//
//  EditNicknameViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import UIKit

final class EditNicknameViewController: UIViewController {
    private let editNicknameView = EditNicknameView()
    
    private var nickname = User(name: "")
    
    override func loadView() {
        view = editNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        bindAction()
    }
}

extension EditNicknameViewController: ViewControllerProtocol {
    func configureNavigation() {
        navigationController?.configureNavigationBar()
        navigationItem.standardAppearance = .defaultBarAppearance
        
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
        editNicknameView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc private func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    //TODO: - 유효하지 않은 데이터가 갔을 때도 닉네임 수정 화면이 변경되어야 하는지?
    @objc private func saveButtonTapped() {
        let newNickname = editNicknameView.nicknameTextField.text!
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
            self.editNicknameView.nicknameTextField.text = nickname.name
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

