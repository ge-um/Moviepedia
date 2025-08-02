//
//  UIViewController+Extension.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import UIKit

extension UIViewController {
    
    // TODO: - 탈퇴 버튼 누르면 UserDefaults에서 닉네임도 지우기.
    func showQuitAlert() {
        let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default) {_ in
            
            NotificationCenter.default.post(name: NSNotification.Name("LoginStatusChanged"), object: nil, userInfo: ["isLoggedIn": false])
            
            NotificationCenter.default.post(name: NSNotification.Name("LoginStatusChanged"), object: nil, userInfo: ["isLoggedIn": false])
            
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
}
