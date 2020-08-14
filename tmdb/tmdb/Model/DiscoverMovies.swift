//  DiscoverMovies.swift
//  tmdb

import Foundation

struct DiscoverMovies: BiCodable {
    let page, totalResults, totalPages: Int
    let all: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case all = "results"
    }
}
