//
//  User.swift
//  Moviepedia
//
//  Created by 금가경 on 8/2/25.
//

import Foundation

struct User {
    let name: String
    
    var isValid: Result<Bool, ValidationError> {
        if !name.isValidLength {
            return .failure(.invalidLength)
        } else if name.hasSpecialCharacter {
            return .failure(.containsSpecialCharacter)
        } else if name.hasNumber {
            return .failure(.containsNumber)
        }
        
        return .success(true)
    }
}
