//
//  MainTabBarController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
}

extension MainTabBarController: ViewControllerProtocol {
    
    func configureTabBar() {
        let vc1 = UINavigationController(rootViewController: MainViewController())
        vc1.tabBarItem.image = UIImage(systemName: "popcorn")
        vc1.tabBarItem.title = "CINEMA"
        
        let vc2 = UIViewController()
        vc2.tabBarItem.image = UIImage(systemName: "film.stack")
        vc2.tabBarItem.title = "UPCOMING"
        
        let vc3 = UINavigationController(rootViewController: SettingsViewController())
        vc3.configureNavigationBar()
        
        vc3.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        vc3.tabBarItem.title = "PROFILE"
        
        viewControllers = [vc1, vc2, vc3]
    }
}
