//
//  SceneDelegate.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // TODO: - UserDefaults에 사용자 로그인 여부 저장 후 UserDefaults로 변경
    var isLoggedIn = false

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.tintColor = .Green
        
        showSplashView()
    }
    
    private func showSplashView() {
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.routeToInitialView()
        }
    }
    
    private func routeToInitialView() {
        let navigationController =  UINavigationController(rootViewController: self.isLoggedIn ? MainViewController() : OnboardingViewController())
        
        navigationController.configureBackButton()
        self.window?.rootViewController = navigationController
    }
}
