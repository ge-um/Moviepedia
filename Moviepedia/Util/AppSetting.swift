//
//  AppSetting.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import Foundation

enum AppSetting {
    // MARK: - User
    @UserDefault(key: "isLoggedIn", defaultValue: false) static var isLoggedIn
    @UserDefault(key: "nickname", defaultValue: "", notificationName: NSNotification.Name("nicknameChanged")) static var nickname
    @UserDefault(key: "signUpDate", defaultValue: Date()) static var signUpDate
    
    // MARK: - Keyword
    @UserDefault(key: "keyword", defaultValue: [], notificationName: NSNotification.Name("keywordSearched")) static var keyword
    
    // MARK: - Like
    @UserDefault(key: "likeMovies", defaultValue: [Int](), notificationName: AppNotification.likeMovieChanged.name) static var likeMovies
}

enum AppNotification: String {
    case nicknameChanged
    case keywordSearched
    case likeMovieChanged
    
    var name: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }
}
