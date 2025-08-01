//
//  ViewControllerProtocol.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

import Foundation

@objc protocol ViewControllerProtocol {
    @objc optional func configureNavigation()
    
    @objc optional func configureTabBar()
    
    @objc optional func bindAction()
}
