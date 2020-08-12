//  Genres.swift
//  tmdb

import Foundation

struct Genre: BiCodable {
  let id: Int
  let name: String
}

struct Genres: BiCodable { //For API Response
  let values: [Genre]

  enum CodingKeys: String, CodingKey {
    case values = "genres"
  }
}
