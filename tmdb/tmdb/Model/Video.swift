//  Video.swift
//  tmdb
import Foundation

struct VideoResponse: Codable {
    let id: Int
    let results: [Video]
}

enum VideoSiteOrigin: String, Codable {
    case youtube = "Youtube"
    case vimeo = "Vimeo"
}

struct Video: Codable {
    let id, iso639_1, iso3166_1, key: String
    let name: String
    let site: VideoSiteOrigin?
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }

    var thumbURL: URL? {
        switch site {
        case .youtube:
            let urlString = "https://img.youtube.com/vi/\(key)/mqdefault.jpg"
            return URL(string: urlString)
        case .vimeo:
            let urlString = "https://vumbnail.com/\(key).jpg"
            return URL(string: urlString)
        case .none:
            return nil
        }
    }

    var videoURL: URL? {
        switch site {
        case .youtube:
            let urlString = "https://www.youtube.com/watch?v=\(key)"
            return URL(string: urlString)
        case .vimeo:
            let urlString = "https://vimeo.com/\(key)"
            return URL(string: urlString)
        case .none:
            return nil
        }
    }
}
