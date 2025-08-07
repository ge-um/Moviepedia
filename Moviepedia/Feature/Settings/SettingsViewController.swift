//
//  SettingsViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    let profileView = ProfileView()
    
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
        configureNavigation()
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
    }
    
    func configureNavigation() {
        navigationItem.title = "설정"
    }

    func bindAction() {
        profileView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeNickname), name: AppNotification.nicknameChanged.name, object: nil)
    }
    
    @objc func editButtonTapped() {
        let modal = UINavigationController(rootViewController: EditNicknameViewController())
        modal.modalPresentationStyle = .pageSheet
        modal.sheetPresentationController?.prefersGrabberVisible = true
        present(modal, animated: true)
    }
    
    @objc func changeNickname(notification: NSNotification) {
        if let nickname = notification.userInfo?["nickname"] as? String {
            profileView.nameLabel.text = nickname
        }
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
