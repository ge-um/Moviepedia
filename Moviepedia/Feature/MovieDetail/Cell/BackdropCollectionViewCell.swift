//
//  BackdropCollectionViewCell.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

import SnapKit
import UIKit

class BackdropCollectionViewCell: BaseCollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension BackdropCollectionViewCell: ViewProtocol {
    func configureSubview() {
        addSubview(imageView)
    }
    
    func configureConstraint() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
