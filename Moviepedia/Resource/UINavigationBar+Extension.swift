//
//  UINavigationBar+Extension.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

extension UINavigationController {
    
    func configureNavigationBar() {
        self.navigationBar.standardAppearance = UINavigationBarAppearance.defaultBarAppearance
    }
}

extension UINavigationBarAppearance {
    
    static var defaultBarAppearance: UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.backButtonAppearance = UIBarButtonItemAppearance.defaultBackButtonAppearance
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.W]
        
        return navigationBarAppearance
    }
}

extension UIBarButtonItemAppearance {
    
    static var defaultBackButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        return backButtonAppearance
    }
}
