//
//  RecentSearchTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import SnapKit
import UIKit

class RecentSearchTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어 내역이 없습니다."
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .Gray2
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubview()
        configureConstraint()
    }
}

extension RecentSearchTableViewCell: ViewProtocol {
    
    func configureSubview() {
        addSubview(label)
    }
    
    func configureConstraint() {
        label.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}
