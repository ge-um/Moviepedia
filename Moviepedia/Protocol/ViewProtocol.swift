//
//  ViewProtocol.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import Foundation

@objc protocol ViewProtocol {
    
    func configureSubview()
    
    func configureConstraint()
    
    @objc optional func configureStyle()
    
    @objc optional func bindAction()
    
    @objc optional func configureInitialData()
}
