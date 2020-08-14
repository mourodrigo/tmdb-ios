//
//  Movie.swift
//  tmdb
//
//  Created by mourodrigo on 8/12/20.
//  Copyright © 2020 mourodrigo. All rights reserved.
//

import Foundation

struct Movie: BiCodable {
    let popularity: Double?
    let id: Int
    let video: Bool?
    let voteCount: Int?
    let voteAverage: Double?
    let title, releaseDate: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview, posterPath: String

    enum CodingKeys: String, CodingKey {
        case popularity, id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
    }
}
