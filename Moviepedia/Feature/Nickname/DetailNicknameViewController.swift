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
    
    var sendNickname: ((User) -> Void)?
        
    override func loadView() {
        view = detailNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        bindAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let nickname = User(name: detailNicknameView.nicknameTextField.text!)
        sendNickname?(nickname)
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
        let name = detailNicknameView.nicknameTextField.text!
        guard !name.isEmpty else {
            detailNicknameView.errorLabel.text = ""
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
        
        detailNicknameView.errorLabel.text = message
    }
}
