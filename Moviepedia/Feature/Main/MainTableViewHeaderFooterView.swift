//
//  MainTableViewHeaderFooterView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import SnapKit
import UIKit

class MainTableViewHeaderFooterView: BaseTableViewHeaderFooterView {
    
    let title: UILabel = {
        let title = UILabel()
        
        title.textColor = .white
        title.font = .systemFont(ofSize: 19, weight: .black)
        
        return title
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureConstraint()
    }
}

extension MainTableViewHeaderFooterView: ViewProtocol {
    
    func configureSubview() {
        contentView.addSubview(title)
    }
    
    func configureConstraint() {
        title.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(layoutMarginsGuide)
            make.verticalEdges.equalTo(contentView).inset(4)
        }
    }
}
