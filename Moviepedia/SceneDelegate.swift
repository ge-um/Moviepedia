//
//  SceneDelegate.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.tintColor = .Green
        
        showSplashView()
        observeUserDefaults()
    }
    
    private func observeUserDefaults() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeLoginStatus), name: NSNotification.Name("LoginStatusChanged"), object: nil)
    }
    
    @objc func changeLoginStatus(notification: NSNotification) {
        guard let status = notification.userInfo?["isLoggedIn"] as? Bool else {
            return
        }
        
        AppSetting.isLoggedIn = status
        routeToInitialView()
    }

    private func showSplashView() {
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.routeToInitialView()
        }
    }

    private func routeToInitialView() {
        let rootViewController: UIViewController
                
        switch AppSetting.isLoggedIn {
            
        case true:
            rootViewController = MainTabBarController()
        case false:
            rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        }

        self.window?.rootViewController = rootViewController
    }
}
