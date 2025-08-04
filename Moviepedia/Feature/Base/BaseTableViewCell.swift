//
//  BaseTableViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell, IsIdentifiable  {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
