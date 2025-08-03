//
//  SettingsView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

final class SettingsView: BaseView {
    
    let profileView = ProfileView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.Gray2
        tableView.separatorInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        tableView.tableHeaderView = UIView()
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubview()
        configureConstraint()
    }
}

extension SettingsView: ViewProtocol {
    
    func configureSubview() {
        addSubview(profileView)
        addSubview(tableView)
    }
    
    func configureConstraint() {
        profileView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.height.equalTo(96)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}

