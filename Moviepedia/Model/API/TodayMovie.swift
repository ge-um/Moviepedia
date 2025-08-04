//
//  TodayMovie.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

struct TodayMovie: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
}
