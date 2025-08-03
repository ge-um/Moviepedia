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
    
    // TODO: - 이렇게 따로따로 네비게이션바를 커스텀하는 방법밖에없는가..
    func configureTabBar() {
        let vc1 = UINavigationController(rootViewController: MainViewController())
        vc1.tabBarItem.image = UIImage(systemName: "popcorn")
        vc1.tabBarItem.title = "CINEMA"
        vc1.configureNavigationBar()
        
        let vc2 = UIViewController()
        vc2.tabBarItem.image = UIImage(systemName: "film.stack")
        vc2.tabBarItem.title = "UPCOMING"
        
        let vc3 = UINavigationController(rootViewController: SettingsViewController())
        vc3.configureNavigationBar()
        
        vc3.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        vc3.tabBarItem.title = "PROFILE"
        
        viewControllers = [vc1, vc2, vc3]
        
        tabBar.barStyle = .black
    }
}
