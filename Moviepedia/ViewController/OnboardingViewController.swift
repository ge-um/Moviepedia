//
//  OnboardingViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let onboardingView = OnboardingView()
    
    override func loadView() {
        view = onboardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
    }
    
    private func bindAction() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        let vc = SettingNicknameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
