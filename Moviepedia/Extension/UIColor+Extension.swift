//
//  UIColor+Extension.swift
//  Moviepedia
//
//  Created by 금가경 on 7/31/25.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension UIColor {
    
    static let Green = UIColor(hex: "98FB98")
    static let Green2 = UIColor(hex: "5F7C5A")
    static let Gray = UIColor(hex: "E1E1E1")
    static let Gray2 = UIColor(hex: "8E8E8E")
    static let Gray3 = UIColor(hex: "2F2F2F")
    static let W = UIColor(hex: "FFFFFF")
    static let B = UIColor(hex: "000000")
    
}
