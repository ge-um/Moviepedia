//
//  Search.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

struct Search: Decodable {
    let results: [SearchMovie]
}

struct SearchMovie: Decodable {
    let title: String
    let genre_ids: [Int]
    let poster_path: String?
    let release_date: String
}
