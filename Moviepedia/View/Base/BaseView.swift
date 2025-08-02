//
//  BaseView.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

// TODO: - ViewProtocol 필수 함수의 호출도 넣기
class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .B
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
