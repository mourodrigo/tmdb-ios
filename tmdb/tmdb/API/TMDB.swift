//  AppDelegate.swift
//  tmdb

import Foundation

class TMDB {
    static private let apiKey = "2783574879d4a595bc685ce83696793d"
    static private let endpoint = "https://api.themoviedb.org/3/"

    enum resourceURL {
        case configuration
        case genres
        case discoverMovies(genreId: Int)

        private var stringValue: String {
            var value = endpoint

            switch self {
            case .configuration:
                value = value.appending("configuration?")
            case .genres:
                value = value.appending("genre/movie/list?")
            case .discoverMovies(let genreId):
                value = value.appending("discover/movie?")
                value = value.appending("with_genres=\(genreId)")
            }

            value = value.appending("&api_key=\(apiKey)")
            value = value.appending("&language=pt-BR")

            return value
        }

        var URLValue: URL {
            guard let url = URL(string: self.stringValue) else {
                fatalError("URLs MUST be valid at \(String(describing: self))")
            }
            return url
        }

        func URLValue(page: Int) -> URL {
            let pagedString = self.stringValue + "&page\(page)"
            guard let url = URL(string: pagedString) else {
                fatalError("URLs MUST be valid at \(String(describing: self))")
            }
            return url
        }
    }
}
