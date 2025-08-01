//
//  SettingNicknameView.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import SnapKit
import UIKit

final class SettingNicknameView: BaseView {
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension SettingNicknameView: ViewProtocol {
    
    func configureSubview() {
        
    }
    
    func configureConstraint() {
        
    }
}
