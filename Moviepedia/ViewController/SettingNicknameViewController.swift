//
//  SettingNicknameViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

class SettingNicknameViewController: UIViewController {
    
    private let settingNicknameView = SettingNicknameView()
    
    override func loadView() {
        view = settingNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "닉네임 설정"
    }
}
