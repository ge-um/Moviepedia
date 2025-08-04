//
//  SynopsisTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import SnapKit
import UIKit

class SynopsisTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 13)
        label.textColor = .W
        label.numberOfLines = 3
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureConstraint()
    }
}

extension SynopsisTableViewCell: ViewProtocol {
    
    func configureSubview() {
        contentView.addSubview(label)
    }
    
    func configureConstraint() {
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(12)
        }
    }
}
