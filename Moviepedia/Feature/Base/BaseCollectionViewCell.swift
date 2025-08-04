//
//  BaseCollectionViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, IsIdentifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
