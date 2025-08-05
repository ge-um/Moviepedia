//
//  MainTableViewHeaderView.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import SnapKit
import UIKit

class MainTableViewHeaderView: BaseTableViewHeaderView {
    
    let title: UILabel = {
        let title = UILabel()
        
        title.textColor = .W
        title.font = .systemFont(ofSize: 18, weight: .bold)
        
        return title
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button.configuration = config
        
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
                
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureConstraint()
    }
    
    @objc func deleteButtonTapped() {
        AppSetting.keyword.removeAll()
    }
}

extension MainTableViewHeaderView: ViewProtocol {
    
    func configureSubview() {
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(button)
        
        contentView.addSubview(stackView)
    }
    
    func configureConstraint() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(12)
            make.verticalEdges.equalTo(contentView)
        }
    }
    
    func configureStyle(buttonTitle: String, buttonIsHidden: Bool = true) {
        let container = AttributeContainer(
            [.font: UIFont.systemFont(ofSize: 15, weight: .heavy)])
        
        button.configuration?.attributedTitle = AttributedString(buttonTitle, attributes: container)
        button.isHidden = buttonIsHidden
    }
    
    func configureWithData(sectionTitle: String) {
        title.text = sectionTitle
    }
}
