//
//  MovieDetailView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import SnapKit
import UIKit

class MovieDetailView: BaseView {
    
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

extension MovieDetailView: ViewProtocol {
    
    func configureSubview() {
        addSubview(tableView)
    }
    
    func configureConstraint() {
        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
