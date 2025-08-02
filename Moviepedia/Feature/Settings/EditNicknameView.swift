//
//  EditNicknameView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import SnapKit
import UIKit

final class EditNicknameView: BaseView {
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        
        textField.textColor = .W
        textField.font = .systemFont(ofSize: 13)
        textField.isEnabled = false
        
        return textField
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 20, bottom: 8, trailing: 20)
        let container = AttributeContainer([.font: UIFont.systemFont(ofSize: 14, weight: .bold), .foregroundColor: UIColor.W])
        
        config.attributedTitle = AttributedString("편집", attributes: container)
        
        config.cornerStyle = .capsule
        config.background.strokeColor = .W
        config.background.strokeWidth = 1
        
        button.configuration = config
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        
        return stackView
    }()
    
    private let line: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension EditNicknameView: ViewProtocol {
    func configureSubview() {
        stackView.addArrangedSubview(nicknameTextField)
        stackView.addArrangedSubview(editButton)
        
        addSubview(stackView)
        addSubview(line)
    }
    
    func configureConstraint() {
        nicknameTextField.snp.contentHuggingHorizontalPriority = 249
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.leading.equalTo(stackView)
            make.trailing.equalTo(stackView).inset(42)
            make.height.equalTo(1)
        }
    }
}
