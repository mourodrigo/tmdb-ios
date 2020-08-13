//  Genres.swift
//  tmdb

import Foundation

struct Genre: BiCodable {
  let id: Int
  let name: String
}

struct Genres: BiCodable { //For API Response
  let all: [Genre]

  enum CodingKeys: String, CodingKey {
    case all = "genres"
  }
}
