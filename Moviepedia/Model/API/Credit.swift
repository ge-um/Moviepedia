//
//  Credit.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

struct Credit: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let character: String
    let profile_path: String?
}
