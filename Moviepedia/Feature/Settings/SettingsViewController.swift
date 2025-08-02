//
//  SettingsViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let profileView = SettingsView()
    private let content = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureTableView()
    }
}

extension SettingsViewController: ViewControllerProtocol {
    
    func configureNavigation() {
        navigationItem.title = "설정"
    }
    
    func configureTableView() {
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
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
}

@available(iOS 17.0, *)
#Preview {
    SettingsViewController()
}
