//
//  DetailNicknameViewController.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

import UIKit

class DetailNicknameViewController: UIViewController {
    private let detailNicknameView = DetailNicknameView()
    
    override func loadView() {
        view = detailNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationItem.title = "닉네임 설정"
    }
}
