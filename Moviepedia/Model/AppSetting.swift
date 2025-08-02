//
//  AppSetting.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import Foundation
// TODO: - 로그인 상태랑 닉네임이랑 따로 있는게 맞을까?
enum AppSetting {
    @UserDefault(key: "isLoggedIn", defaultValue: false) static var isLoggedIn
    @UserDefault(key: "nickname", defaultValue: "", notificationName: NSNotification.Name("nicknameChanged")) static var nickname
    @UserDefault(key: "signUpDate", defaultValue: Date()) static var signUpDate
}
