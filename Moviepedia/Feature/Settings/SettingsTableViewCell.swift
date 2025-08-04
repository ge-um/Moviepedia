//
//  SettingsTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

class SettingsTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .W
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureConstraint()
    }
}

extension SettingsTableViewCell: ViewProtocol {
    
    func configureSubview() {
        addSubview(label)
    }
    
    func configureConstraint() {
        label.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureWithData(content: String) {
        label.text = content
    }
}
