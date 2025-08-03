//
//  MainView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    
    let profileView = ProfileView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension MainView: ViewProtocol {
    
    func configureSubview() {
        addSubview(profileView)
        addSubview(tableView)
    }
    
    func configureConstraint() {
        profileView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(108)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}

