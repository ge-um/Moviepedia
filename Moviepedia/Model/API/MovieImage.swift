//
//  MovieImage.swift
//  Moviepedia
//
//  Created by 금가경 on 8/4/25.
//

struct MovieImage: Decodable {
    let id: Int
    let backdrops: [Backdrop]
}

struct Backdrop: Decodable {
    let file_path: String
}
