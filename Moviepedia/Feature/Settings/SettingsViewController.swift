//
//  SettingsViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    lazy var profileView: ProfileView = {
        let view = ProfileView()
        
        view.onEditButtonTapped = {
            let modal = UINavigationController(rootViewController: EditNicknameViewController())
            modal.modalPresentationStyle = .pageSheet
            modal.sheetPresentationController?.prefersGrabberVisible = true
            self.present(modal, animated: true)
        }
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.Gray2
        tableView.separatorInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        return tableView
    }()
    
    private let content = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubview()
        configureConstraint()
        configureStyle()
        bindAction()
    }
}

extension SettingsViewController: ViewControllerProtocol {
    
    func configureSubview() {
        view.addSubview(profileView)
        view.addSubview(tableView)
    }
    
    func configureConstraint() {
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(96)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureStyle() {
        view.backgroundColor = .B
        navigationItem.title = "설정"
    }

    func bindAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeNickname), name: AppNotification.nicknameChanged.name, object: nil)
    }

    @objc func changeNickname(notification: NSNotification) {
        if let nickname = notification.userInfo?["nickname"] as? String {
            profileView.nameLabel.text = nickname
        }
    }
    
    func showQuitAlert() {
        let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default) {_ in
            
            NotificationCenter.default.post(name: NSNotification.Name("LoginStatusChanged"), object: nil, userInfo: ["isLoggedIn": false])
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier) as! SettingsTableViewCell
        
        cell.configureWithData(content: content[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row == 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showQuitAlert()
    }
}
