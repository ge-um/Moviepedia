//
//  UserDefault.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let notificationName: NSNotification.Name?
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key)
            
            if let name = notificationName {
                NotificationCenter.default.post(name: name, object: nil, userInfo: [key: newValue])
            }
        }
    }
    
    // TODO: - 기본값 줘도 될지 생각해보기
    init(key: String, defaultValue: T, notificationName: NSNotification.Name? = Notification.Name("")) {
        self.key = key
        self.defaultValue = defaultValue
        self.notificationName = notificationName
    }
    
}
