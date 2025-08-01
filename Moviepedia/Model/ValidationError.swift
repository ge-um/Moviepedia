//
//  ValidationError.swift
//  Moviepedia
//
//  Created by 금가경 on 8/1/25.
//

import Foundation

enum ValidationError: Error {
    case invalidLength
    case containsSpecialCharacter
    case containsNumber
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidLength:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .containsSpecialCharacter:
            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
        case .containsNumber:
            return "닉네임에 숫자는 포함할 수 없어요"
        }
    }
}
