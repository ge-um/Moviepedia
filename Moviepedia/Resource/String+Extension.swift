//
//  String+Extension.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

// TODO: - 이러한 경우에 한 번만 계산하는가?
// TODO: - String extension에 계산값을 넣어두는게 맞을까?
extension String {
    
    var isValidLength: Bool {
        return (2..<10) ~= self.count
    }
    
    var hasSpecialCharacter: Bool {
        let specialCharacterRegex = /[@#$%]/
        return self.contains(specialCharacterRegex)
    }
    
    var hasNumber: Bool {
        let numberRegex = /[0-9]/
        return self.contains(numberRegex)
    }
}
