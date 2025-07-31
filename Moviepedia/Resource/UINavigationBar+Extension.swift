//
//  UINavigationBar+Extension.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

extension UINavigationController {
    func configureBackButton() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationBarAppearance.backButtonAppearance = backButtonAppearance
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
