//
//  SettingsView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

class SettingsView: BaseView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.Gray2
        tableView.separatorInset = .init(top: 0, left: 12, bottom: 0, right: 12)

        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubview()
        configureConstraint()
        
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
    }
}

extension SettingsView: ViewProtocol {
    
    func configureSubview() {
        addSubview(tableView)
    }
    
    func configureConstraint() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.verticalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
