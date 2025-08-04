//
//  BaseTableViewHeaderFooterView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import UIKit

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView, IsIdentifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
