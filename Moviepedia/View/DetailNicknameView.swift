//
//  DetailNicknameView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

import UIKit

class DetailNicknameView: BaseView {
    // TODO: - 컴포넌트 재사용 고민해보기
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .W
        textField.font = .systemFont(ofSize: 13)
        
        return textField
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임에 숫자는 포함할 수 없어요"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .Green
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension DetailNicknameView: ViewProtocol {
    
    func configureSubview() {
        addSubview(nicknameTextField)
        addSubview(line)
        addSubview(errorLabel)
    }
    
    func configureConstraint() {
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.horizontalEdges.equalTo(nicknameTextField)
            make.height.equalTo(1)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(nicknameTextField).inset(8)
        }
    }
}
