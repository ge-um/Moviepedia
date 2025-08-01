//
//  UIButton+Extension.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

import UIKit

extension UIButton.Configuration {
    
    static func bordered(title: String) -> Self {
        var config = UIButton.Configuration.plain()
        let container = AttributeContainer([.font: UIFont.systemFont(ofSize: 15, weight: .bold)])
        
        config.attributedTitle = AttributedString(title, attributes: container)
        config.cornerStyle = .capsule
        config.background.strokeColor = .Green
        config.background.strokeWidth = 1
        
        return config
    }
}
