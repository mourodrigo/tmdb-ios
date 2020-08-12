//  AppDelegate.swift
//  tmdb

import Foundation

class TMDB {
    static private let apiKey = "2783574879d4a595bc685ce83696793d"
    static private let endpoint = "https://api.themoviedb.org/3/"

    enum resourceURL {
        case configuration
        case genres

        var URLValue: URL {
            var value = endpoint

            switch self {
            case .configuration:
                value = value.appending("configuration")
            case .genres:
                value = value.appending("genre/movie/list")
            }

            value = value.appending("?") //starting with params
            value = value.appending("api_key=\(apiKey)")
            value = value.appending("&language=pt-BR")

            guard let url = URL(string: value) else {
                fatalError("URLs MUST be valid at \(String(describing: self))")
            }
            return url
        }
    }
}
