//
//  SplashView.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import SnapKit
import UIKit

final class SplashView: BaseView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")
        imageView.contentMode = .top
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Moviepedia"
        label.font = .init(name: "HelveticaNeue-BoldItalic", size: 36)
        label.textColor = .W
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "금가경"
        label.textColor = .W
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureConstraint()
    }
}

extension SplashView: ViewProtocol {
    func configureSubview() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(nameLabel)
        
        addSubview(stackView)
    }
    
    func configureConstraint() {
        imageView.snp.contentHuggingVerticalPriority = 249
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(172)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}
