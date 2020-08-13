//
//  DiscoverMovies.swift
//  tmdb
//
//  Created by mourodrigo on 8/12/20.
//  Copyright © 2020 mourodrigo. All rights reserved.
//

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
